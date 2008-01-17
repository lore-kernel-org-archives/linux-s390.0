Return-Path: <linux-kernel-owner+w=401wt.eu-S1755605AbYAQMmS@vger.kernel.org>
Message-ID: <478F4D05.2070803@linux.vnet.ibm.com>
Date: Thu, 17 Jan 2008 18:11:41 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: 2.6.24-rc8-mm1 Build Failure on S390x
References: <20080117023514.9df393cf.akpm@linux-foundation.org>
In-Reply-To: <20080117023514.9df393cf.akpm@linux-foundation.org>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux390@de.ibm.com, linux-s390@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>
List-ID: <linux-s390.vger.kernel.org>

Hi Andrew,

The 2.6.24-rc8-mm1 kernel build fails on S390x with build error

arch/s390/kernel/ipl.c: In function `ipl_register_fcp_files':
arch/s390/kernel/ipl.c:415: error: `ipl_subsys' undeclared (first use in this function)
arch/s390/kernel/ipl.c:415: error: (Each undeclared identifier is reported only once
arch/s390/kernel/ipl.c:415: error: for each function it appears in.)
arch/s390/kernel/ipl.c: In function `ipl_init':
arch/s390/kernel/ipl.c:449: error: implicit declaration of function `firmware_register'
arch/s390/kernel/ipl.c:449: error: `ipl_subsys' undeclared (first use in this function)
  CC      arch/s390/kernel/dis.o
arch/s390/kernel/ipl.c: In function `on_panic_show':
arch/s390/kernel/ipl.c:766: error: implicit declaration of function `shutdown_action_str'
arch/s390/kernel/ipl.c:766: error: `on_panic_action' undeclared (first use in this function)
arch/s390/kernel/ipl.c:766: warning: format argument is not a pointer (arg 3)
arch/s390/kernel/ipl.c:766: warning: format argument is not a pointer (arg 3)
arch/s390/kernel/ipl.c: In function `on_panic_store':
arch/s390/kernel/ipl.c:773: error: `SHUTDOWN_REIPL_STR' undeclared (first use in this function)
arch/s390/kernel/ipl.c:774: error: `on_panic_action' undeclared (first use in this function)
arch/s390/kernel/ipl.c:774: error: `SHUTDOWN_REIPL' undeclared (first use in this function)
arch/s390/kernel/ipl.c:775: error: `SHUTDOWN_DUMP_STR' undeclared (first use in this function)
arch/s390/kernel/ipl.c:777: error: `SHUTDOWN_DUMP' undeclared (first use in this function)
arch/s390/kernel/ipl.c:778: error: `SHUTDOWN_STOP_STR' undeclared (first use in this function)
arch/s390/kernel/ipl.c:780: error: `SHUTDOWN_STOP' undeclared (first use in this function)
arch/s390/kernel/ipl.c: At top level:
arch/s390/kernel/ipl.c:879: error: redefinition of 'ipl_register_fcp_files'
arch/s390/kernel/ipl.c:412: error: previous definition of 'ipl_register_fcp_files' was here
arch/s390/kernel/ipl.c:904: error: redefinition of 'ipl_init'
arch/s390/kernel/ipl.c:446: error: previous definition of 'ipl_init' was here
arch/s390/kernel/ipl.c:1050: error: `reipl_run' undeclared here (not in a function)
arch/s390/kernel/ipl.c:1050: error: initializer element is not constant
arch/s390/kernel/ipl.c:1050: error: (near initialization for `reipl_action.fn')
arch/s390/kernel/ipl.c:1058: error: redefinition of 'sys_dump_fcp_wwpn_show'
arch/s390/kernel/ipl.c:664: error: previous definition of 'sys_dump_fcp_wwpn_show' was here
arch/s390/kernel/ipl.c:1058: error: redefinition of 'sys_dump_fcp_wwpn_store'
arch/s390/kernel/ipl.c:664: error: previous definition of 'sys_dump_fcp_wwpn_store' was here
arch/s390/kernel/ipl.c:1058: error: redefinition of 'sys_dump_fcp_wwpn_attr'
arch/s390/kernel/ipl.c:664: error: previous definition of 'sys_dump_fcp_wwpn_attr' was here
arch/s390/kernel/ipl.c:1060: error: redefinition of 'sys_dump_fcp_lun_show'
arch/s390/kernel/ipl.c:666: error: previous definition of 'sys_dump_fcp_lun_show' was here
arch/s390/kernel/ipl.c:1060: error: redefinition of 'sys_dump_fcp_lun_store'
arch/s390/kernel/ipl.c:666: error: previous definition of 'sys_dump_fcp_lun_store' was here
arch/s390/kernel/ipl.c:1060: error: redefinition of 'sys_dump_fcp_lun_attr'
arch/s390/kernel/ipl.c:666: error: previous definition of 'sys_dump_fcp_lun_attr' was here
arch/s390/kernel/ipl.c:1062: error: redefinition of 'sys_dump_fcp_bootprog_show'
arch/s390/kernel/ipl.c:668: error: previous definition of 'sys_dump_fcp_bootprog_show' was here
arch/s390/kernel/ipl.c:1062: error: redefinition of 'sys_dump_fcp_bootprog_store'
arch/s390/kernel/ipl.c:668: error: previous definition of 'sys_dump_fcp_bootprog_store' was here
arch/s390/kernel/ipl.c:1062: error: redefinition of 'sys_dump_fcp_bootprog_attr'
arch/s390/kernel/ipl.c:668: error: previous definition of 'sys_dump_fcp_bootprog_attr' was here
arch/s390/kernel/ipl.c:1064: error: redefinition of 'sys_dump_fcp_br_lba_show'
arch/s390/kernel/ipl.c:670: error: previous definition of 'sys_dump_fcp_br_lba_show' was here
arch/s390/kernel/ipl.c:1064: error: redefinition of 'sys_dump_fcp_br_lba_store'
arch/s390/kernel/ipl.c:670: error: previous definition of 'sys_dump_fcp_br_lba_store' was here
arch/s390/kernel/ipl.c:1064: error: redefinition of 'sys_dump_fcp_br_lba_attr'
arch/s390/kernel/ipl.c:670: error: previous definition of 'sys_dump_fcp_br_lba_attr' was here
arch/s390/kernel/ipl.c:1066: error: redefinition of 'sys_dump_fcp_device_show'
arch/s390/kernel/ipl.c:672: error: previous definition of 'sys_dump_fcp_device_show' was here
arch/s390/kernel/ipl.c:1066: error: redefinition of 'sys_dump_fcp_device_store'
arch/s390/kernel/ipl.c:672: error: previous definition of 'sys_dump_fcp_device_store' was here
arch/s390/kernel/ipl.c:1066: error: redefinition of 'sys_dump_fcp_device_attr'
arch/s390/kernel/ipl.c:672: error: previous definition of 'sys_dump_fcp_device_attr' was here
arch/s390/kernel/ipl.c:1069: error: redefinition of 'dump_fcp_attrs'
arch/s390/kernel/ipl.c:675: error: previous definition of 'dump_fcp_attrs' was here
arch/s390/kernel/ipl.c:1078: error: redefinition of 'dump_fcp_attr_group'
arch/s390/kernel/ipl.c:684: error: previous definition of 'dump_fcp_attr_group' was here
arch/s390/kernel/ipl.c:1085: error: redefinition of 'sys_dump_ccw_device_show'
arch/s390/kernel/ipl.c:691: error: previous definition of 'sys_dump_ccw_device_show' was here
arch/s390/kernel/ipl.c:1085: error: redefinition of 'sys_dump_ccw_device_store'
arch/s390/kernel/ipl.c:691: error: previous definition of 'sys_dump_ccw_device_store' was here
arch/s390/kernel/ipl.c:1085: error: redefinition of 'sys_dump_ccw_device_attr'
arch/s390/kernel/ipl.c:691: error: previous definition of 'sys_dump_ccw_device_attr' was here
arch/s390/kernel/ipl.c:1088: error: redefinition of 'dump_ccw_attrs'
arch/s390/kernel/ipl.c:694: error: previous definition of 'dump_ccw_attrs' was here
arch/s390/kernel/ipl.c:1093: error: redefinition of 'dump_ccw_attr_group'
arch/s390/kernel/ipl.c:699: error: previous definition of 'dump_ccw_attr_group' was here
arch/s390/kernel/ipl.c:1101: error: redefinition of 'dump_set_type'
arch/s390/kernel/ipl.c:707: error: previous definition of 'dump_set_type' was here
arch/s390/kernel/ipl.c:1124: error: conflicting types for 'dump_type_show'
arch/s390/kernel/ipl.c:731: error: previous definition of 'dump_type_show' was here
arch/s390/kernel/ipl.c:1130: error: conflicting types for 'dump_type_store'
arch/s390/kernel/ipl.c:738: error: previous definition of 'dump_type_store' was here
arch/s390/kernel/ipl.c:1142: error: variable `dump_type_attr' has initializer but incomplete type
arch/s390/kernel/ipl.c:1142: error: conflicting types for 'dump_type_attr'
arch/s390/kernel/ipl.c:750: error: previous definition of 'dump_type_attr' was here
arch/s390/kernel/ipl.c:1143: error: unknown field `attr' specified in initializer
arch/s390/kernel/ipl.c:1143: error: extra brace group at end of initializer
arch/s390/kernel/ipl.c:1143: error: (near initialization for `dump_type_attr')
arch/s390/kernel/ipl.c:1143: warning: excess elements in struct initializer
arch/s390/kernel/ipl.c:1143: warning: (near initialization for `dump_type_attr')
arch/s390/kernel/ipl.c:1143: error: unknown field `show' specified in initializer
arch/s390/kernel/ipl.c:1143: warning: excess elements in struct initializer
arch/s390/kernel/ipl.c:1143: warning: (near initialization for `dump_type_attr')
arch/s390/kernel/ipl.c:1143: error: unknown field `store' specified in initializer
arch/s390/kernel/ipl.c:1143: warning: excess elements in struct initializer
arch/s390/kernel/ipl.c:1143: warning: (near initialization for `dump_type_attr')
arch/s390/kernel/ipl.c:1145: error: syntax error before '(' token
arch/s390/kernel/ipl.c: In function `dump_init':
arch/s390/kernel/ipl.c:1233: warning: passing arg 2 of `sysfs_create_file' from incompatible pointer type
arch/s390/kernel/ipl.c: In function `shutdown_actions_init':
arch/s390/kernel/ipl.c:1256: warning: passing arg 2 of `sysfs_create_file' from incompatible pointer type
arch/s390/kernel/ipl.c:1262: error: `shutdown_on_panic_nb' undeclared (first use in this function)
arch/s390/kernel/ipl.c: At top level:
arch/s390/kernel/ipl.c:237: warning: 'get_ipl_type' defined but not used
arch/s390/kernel/ipl.c:477: warning: 'ipl_action' defined but not used
arch/s390/kernel/ipl.c:684: warning: 'dump_fcp_attr_group' defined but not used
arch/s390/kernel/ipl.c:699: warning: 'dump_ccw_attr_group' defined but not used
arch/s390/kernel/ipl.c:750: warning: 'dump_type_attr' defined but not used
arch/s390/kernel/ipl.c:843: warning: 'do_dump' defined but not used
arch/s390/kernel/ipl.c:1049: warning: 'reipl_action' defined but not used
arch/s390/kernel/ipl.c:1148: warning: 'dump_run' defined but not used
make[1]: *** [arch/s390/kernel/ipl.o] Error 1
make[1]: *** Waiting for unfinished jobs....

-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
