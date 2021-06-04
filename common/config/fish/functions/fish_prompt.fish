function fish_prompt
	if not set -q -g __fish_robbyrussell_functions_defined
    set -g __fish_robbyrussell_functions_defined
    function _git_branch_name
      echo (git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
    end

    function _is_git_dirty
      echo (git status -s --ignore-submodules=dirty ^/dev/null)
    end

    function _is_git_repo
      type -q git; or return 1
      git status -s >/dev/null ^/dev/null
    end

    function _hg_branch_name
      echo (hg branch ^/dev/null)
    end

    function _is_hg_dirty
      echo (hg status -mard ^/dev/null)
    end

    function _is_hg_repo
      type -q hg; or return 1
      hg summary >/dev/null ^/dev/null
    end

    function _repo_branch_name
      eval "_$argv[1]_branch_name"
    end

    function _is_repo_dirty
      eval "_is_$argv[1]_dirty"
    end

    function _repo_type
      if _is_hg_repo
        echo 'hg'
      else if _is_git_repo
        echo 'git'
      end
    end
  end

#         ﲏ 
# https://github.com/vim-airline/vim-airline-themes/blob/master/autoload/airline/themes/base16_oceanicnext.vim

  set -l repo_type (_repo_type)
  if [ $repo_type ]
    set -l repo_branch (_repo_branch_name $repo_type)
    set repo_info "$repo_branch"
  end

  set -g fish_term24bit 1
  set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
  set host "$__fish_prompt_hostname"

  echo -n (set_color -b 5FB3B3)(set_color D8DEE9)
  #if [ string match -q (uname) "Darwin" ]
  switch (uname -a | cut -d ' ' -f 1)
    case 'Linux'
      echo -n "  "
    case 'Darwin'
      echo -n "  "
  end
  echo -n " "$host" "
  echo -n (set_color -b 4f5b66)(set_color 5FB3B3)""


  if [ $repo_type ]
    set -l cwd (basename (git rev-parse --show-toplevel))
    set -l subpwd (string replace (git rev-parse --show-toplevel) "" (pwd))
    set -l ahead (string match "*ahead*" (git status -s -b))
    set -l behind (string match "*behind*" (git status -s -b))

    echo -n (set_color a7adba)"  "$repo_info" "
    echo -n (set_color -b 343d46)(set_color 4f5b66)""
    if [ (_is_repo_dirty $repo_type) ]
      echo -n (set_color -b 343d46)(set_color f99157)"  "$cwd$subpwd" "
    else if [ $ahead ]
      echo -n (set_color -b 343d46)(set_color fac863)"  "$cwd$subpwd" "
    else if [ $behind ]
      echo -n (set_color -b 343d46)(set_color ec5f67)"  "$cwd$subpwd" "
    else
      echo -n (set_color -b 343d46)(set_color 99C794)"  "$cwd$subpwd" "
    end

  else
    set -l cwd (basename (prompt_pwd))
    echo -n (set_color -b 343d46)(set_color 4f5b66)""
    echo -n (set_color -b 343d46)(set_color A7ADBA)"   "$cwd" "
  end
  echo -n (set_color normal)(set_color 343d46)" "

  echo -n (set_color normal)
end
