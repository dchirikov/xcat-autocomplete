function _xcat_tabedit() { 
    local cur=${COMP_WORDS[COMP_CWORD]};
    COMPREPLY=($(compgen -W "`tabdump` -h --help -?" -- $cur))
    return 0
}

function _xcat_tabdump() {
    local cur=${COMP_WORDS[COMP_CWORD]};
    local prev=${COMP_WORDS[COMP_CWORD-1]}
    local prev2=${COMP_WORDS[COMP_CWORD-2]}
    case "$prev2" in
        -w|-f)
            COMPREPLY=($(compgen -W "`tabdump`" -- $cur))
            return 0
            ;;
        -n)
            COMPREPLY=($(compgen -W "auditlog eventlog" -- $cur))
            return 0
            ;;

    esac
    case "$prev" in
        -d)
            COMPREPLY=($(compgen -W "`tabdump`" -- $cur))
            return 0
            ;;
        -f)
            COMPREPLY=($(compgen -W "`ls`" -- $cur))
            return 0
            ;;
	-w)
            COMPREPLY=($(compgen -P \' -S \'  -W "adddhcpstatements addkcmdline adminpassword adminuser application appstatus appstatustime \
                                     arch args asset attrname attrvalue audittime auth authdomain basename beacon begin bmc bmcid \
                                     bmcport bootorder boottarget bosinst_data bprofile bridge cfgfile cfgmgr cfgserver cfgstore \
                                     cfmdir chain chassis clientname clienttype clockoffset cluster cmd cmdinterface cmdmapping \
                                     command commands comments compat_osbasenames component configdump cons conserver \
                                     consoleondemand cpucount cpus cputype crashkernelsize cryptmethod currchain current_osimage \
                                     currstate datacenter ddnsdomain defaultnet defaultzone description dhcpinterfaces dhcpserver \
                                     dhcpstatements directory dirpath dirpaths disable discoverynics discoverytime disksize displayname \
                                     domain downloadtime driverpacks driverupdatesrc dump dynamicrange end eventtime eventtype exlist \
                                     expire fb_script fcprange file filename ftpserver gateway genimage_postinstall getmac groupname \
                                     groups grouptype guestostype hcp height hidden home host hostnames hypervisor id ifname image \
                                     image_data imagename imagetype iname initrd installnic installp_bundle installto interface ip \
                                     ipforward isdeletable isinternal kcmdline kernel kerneldir kernelver key kitcompdeps kitcompname \
                                     kitcomponents kitdeployparams kitdir kitname kitpkgdeps kitrepodir kitreponame krpmver ldapserver \
                                     linkports location logservers lpp_source lun mac majorversion mask master membergroups members \
                                     memory message method mgr mgt mgtifname migrationdest minorversion mksysb mntopts monitor \
                                     monnode monserver mpa msdelay mtm name nameserver nameservers net netboot netdrivers netmap \
                                     netname next_osimage nfsdir nfsserver nicaliases niccustomscripts nicdriver nicfirm \
                                     nichostnameprefixes nichostnamesuffixes nichwaddr nicips nicipv4 nicloc nicmodel nicnetworks \
                                     niconboard nicpci nics nictypes nimmethod nimserver nimtype node nodebootif nodedep \
                                     nodehostname noderange nodestatmon nodetype ntpserver ntpservers num onboot ondiscover \
                                     options originator os osarch osbasename osdistroname osmajorversion osminorversion osname \
                                     ostype osupdatename osvers osvolume otherdata otherifce otherinterfaces otherpkgdir \
                                     otherpkglist otherpkgs othersettings ou paging parameters parent partitionfile \
                                     passwd password permission physlots pkgdir pkglist port postbootscripts postinstall \
                                     postscripts power powermgt powerstate pprofile preferdirect prerequisite primarynic \
                                     primarysn priority privacy product profile protocol provmethod proxydhcp rack rackname \
                                     rawdata recid release res_group resolv_conf roles room root rootfstype rootimgdir routename \
                                     routenames rule script sdtype serial serialflow serialport serialspeed server serverrole \
                                     serverroles servicenode severity sfp shared_home shared_root side size slot slots snmpversion \
                                     specializeparameters spot sshbetweennodes sshkeydir sshpassword sshusername state statemnt \
                                     staticrange staticrangeincrement status statustime storage storagecache storageformat \
                                     storagemodel storagepool stype supernode supportedarchs switch switchaddr switchdesc \
                                     switchname switchport switchtype synclists tableops tables taggedvlan target template \
                                     termport termserver textconsole tftpdir tftpserver time timestamp tmp tokenid type u \
                                     updatestatus updatestatustime urlpath userid username uuid value version vidmodel \
                                     vidpassword vidproto vintage virtflags virttype vlan vlanid vlog vncport volumetag \
                                     wherevals winpepath xcatmaster xml zonename" -- $cur))
            return 0
            ;;
    esac
    if [[ "$cur" == * ]]; then   
            COMPREPLY=($(compgen -W "`tabdump` -d -f -n -w -v -h -? --help" -- $cur))
    fi
}
function _xcat_lsdef() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    local prev=${COMP_WORDS[COMP_CWORD-1]}
    def_parm="-h --help -t -i -V --verbose -l --long -s --short -a --all -S -o -z  -c --compress --osimage --nics -w"
    case "$prev" in 
        -t)
            COMPREPLY=($(compgen -W "`lsdef -t 2>/dev/null| sed '1,/The following data/d;/ /,$d' | tr '\n' ' '`" -- $cur))
            return 0
            ;;
        -i)
            cmd=$(printf " %s" "${COMP_WORDS[@]}")
            cmd_wo_i=${cmd%%-i*}
            COMPREPLY=($(compgen -W  "`$cmd_wo_i | sed -e '1d;s/^\W\+\([a-z]\+\)=.*$/\1/'`" -- $cur))
            return 0
            ;;
        -o)
            cmd=$(printf " %s" "${COMP_WORDS[@]}")
            tmp_t_parm=${cmd#*-t }
            cmd_t_parm=${tmp_t_parm%% *}
            if [ ! -z $cmd_t_parm ]; then
                COMPREPLY=($(compgen -W "`lsdef -t $cmd_t_parm | awk '{print $1}'`" -- $cur))
            fi
    esac
    cmd=$(printf " %s" "${COMP_WORDS[@]}")
    tmp_t_parm=${cmd#*-t }
    cmd_t_parm=${tmp_t_parm%% *}
    if [ ! -z $cmd_t_parm ]; then
#        echo $cmd_t_parm
        COMPREPLY=($(compgen -W "`lsdef -t $cmd_t_parm | awk '{print $1}'` $def_parm" -- $cur))
    else
        COMPREPLY=($(compgen -W "`(lsdef -t group; lsdef -t node) | awk '{print $1}'` $def_parm" -- $cur))
    fi
}
function _xcat_chdef() {
    compopt +o bashdefault +o default +o dirnames +o filenames +o nospace +o plusdirs
    local cur=${COMP_WORDS[COMP_CWORD]}
    local prev=${COMP_WORDS[COMP_CWORD-1]}
    local def_parm=" -h -V -t -o -n -w -u -d --dynamic -p --plus -m --minus -z --stanza"
    local noderange=""
    case "$prev" in
        -t)
            COMPREPLY=($(compgen -W "`lsdef -t 2>/dev/null| sed '1,/The following data/d;/ /,$d' | tr '\n' ' '`" -- $cur))
            return 0
            ;;
        -u)
            compopt -o nospace
            COMPREPLY=($(compgen -S\= -W "provmethod" -- $cur))
            return 0
            ;;
         provmethod)
compopt -o nospace
            COMPREPLY=($(compgen  -W "a b c" -- $cur))
echo 1
            return 0
            ;;
    esac
    local cmd=$(printf " %s" "${COMP_WORDS[@]}")
    cmd=${cmd:1}
    cmd=${cmd::$((${#cmd}-${#cur}))}
    local arr_cmd
    IFS=' ' read -a arr_cmd <<< "$cmd"
    local a_type
    local arr_parm=()
    for ((i=1; i < ${#arr_cmd[@]}; i++)); do
	local arg=${arr_cmd[$i]}
        case "$arg" in 
            -V|-d|--dynamic|-p|--plus|-m|--minus|-z|--stanza)
                continue
                ;;
            -h)
                def_parm=" -t"
                continue
                ;;
            -n)
                def_parm=" -t -o"
                continue
                ;;
            -t)
                ((i++))
                a_type=${arr_cmd[$i]}
                def_parm=${def_parm#* -h}
                def_parm=${def_parm#* -t}
                continue
                ;;
            -w)
                ((i++)); ((i++))
                def_parm=" -u"
                continue
                ;;
            -u)
                ((i++)); ((i++))
                def_parm=""
                continue 
                ;;
            -o)
                ((i++))
                noderange=${arr_cmd[$i]}
                def_parm=" -u"
                ;;
            *"="*)
                def_parm=""
		arr_parm+=${arg%=*}
                continue
                ;;
            *)
                noderange=${arr_cmd[$i]}
                def_parm=" -u"
                ;;
        esac
    done
    if [ ! -z "$noderange" ]; then
         local parm=$(lsdef -t node $noderange | sed -n 's/^\W\+\([a-z]\+\)=.*$/\1/p'  | sort | uniq | tr '\n' ' ') 
         compopt -o nospace
         COMPREPLY=($(compgen -S\= -W "$parm $def_parm" -- $cur))
         return 0
    fi
    if [ ! -z "$a_type" ]; then
       COMPREPLY=($(compgen  -W "`lsdef -t $a_type | awk '{print $1}'` $def_parm" -- $cur))
       return 0
    fi
    COMPREPLY=($(compgen  -W "`(lsdef -t group; lsdef -t node) | awk '{print $1}'` $def_parm" -- $cur))
    return 0
}
complete -F _xcat_tabedit tabedit
complete -F _xcat_tabdump tabdump
complete -F _xcat_chdef chdef
complete -F _xcat_lsdef lsdef
