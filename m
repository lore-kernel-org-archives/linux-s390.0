Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9868 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726885AbgEDI72 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 May 2020 04:59:28 -0400
Subject: Re: s390 KVM warning in handle_pqap()
References: <ED53E46F-EF53-46F6-B88E-2035965AB20C@icloud.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <57992d1f-434e-3900-1958-542cd830aad1@de.ibm.com>
Date: Mon, 4 May 2020 10:59:19 +0200
MIME-Version: 1.0
In-Reply-To: <ED53E46F-EF53-46F6-B88E-2035965AB20C@icloud.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Qian Cai <cailca@icloud.com>, Pierre Morel <pmorel@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>



On 02.05.20 04:38, Qian Cai wrote:
> This line,
> 
> if (WARN_ON_ONCE(fc != 0x03))
> 
> qemu-kvm-2.12.0-99.module+el8.2.0+5827+8c39933c with this kernel config,
> 
> https://raw.githubusercontent.com/cailca/linux-mm/master/s390.config
> 
> # /usr/libexec/qemu-kvm -name ubuntu-18.04-server-cloudimg -cpu host -smp 2 -m 2G -hda ubuntu-18.04-server-cloudimg.qcow2 -cdrom ubuntu-18.04-server-cloudimg.iso -nic user,hostfwd=tcp::2222-:22 -nographic
> 
> 00: [  424.578896] WARNING: CPU: 0 PID: 1533 at arch/s390/kvm/priv.c:632 handle_
> 00: pqap+0x2b6/0x468 [kvm]                                                      
> 00: [  424.578934] Modules linked in: kvm ip_tables x_tables xfs dasd_fba_mod da
> 00: sd_eckd_mod dm_mirror dm_region_hash dm_log dm_mod                          
> 00: [  424.579026] CPU: 0 PID: 1533 Comm: qemu-kvm Not tainted 5.7.0-rc3-next-20
> 00: 200501 #2                                                                   
> 00: [  424.579064] Hardware name: IBM 2964 N96 400 (z/VM 6.4.0)                 

You run nested unter z/VM (under LPAR). So it looks like z/VM behaves different to
LPAR regarding the interception of the PQAP instruction. 
Tony, can you talk to your z/VM colleagues about this? I guess we might need to 
remove the WARN_ON_ONCE(fc != 0x03) and simply return EOPNOTSUPP if our assumption
is not right. I guess z/VM has its ECA field set to 0 so the effective ECA field
is also 0.



> 00: [  424.579101] Krnl PSW : 0704d00180000000 000003ff80440dc2 (handle_pqap+0x2
> 00: ba/0x468 [kvm])                                                             
> 00: [  424.579239]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0
> 00:  RI:0 EA:3                                                                  
> 00: [  424.579282] Krnl GPRS: 0000000000000000 0000030000000000 0000030000000000
> 00:  00000000e1ca6148                                                           
> 00: [  424.579320]            0000030000000000 000003ff80440c14 0000000000000000
> 00:  00000000822e8520                                                           
> 00: [  424.579359]            00000000e1ca6000 000000009c79a000 00000000822e8008
> 00:  0000007c00877e70                                                           
> 00: [  424.579399]            000003ff803f5000 000003ff80467528 000003ff80440c14
> 00:  000003e0043bf2c8                                                           
> 00: [  424.579461] Krnl Code: 000003ff80440db6: a774ff5a            brc     7,00
> 00: 0003ff80440c6a                                                              
> 00: [  424.579461]            000003ff80440dba: a7f4ff54            brc     15,0
> 00: 00003ff80440c62                                                             
> 00: [  424.579461]           #000003ff80440dbe: af000000            mc      0,0 
> 00: [  424.579461]           >000003ff80440dc2: a798ffa1            lhi     %r9,
> 00: -95                                                                         
> 00: [  424.579461]            000003ff80440dc6: a51d0300            llihl   %r1,
> 00: 768                                                                         
> 00: [  424.579461]            000003ff80440dca: b90800b1            agr     %r11
> 00: ,%r1                                                                        
> 00: [  424.579461]            000003ff80440dce: d70bb000b000        xc      0(12
> 00: ,%r11),0(%r11)                                                              
> 00: [  424.579461]            000003ff80440dd4: b9140029            lgfr    %r2,
> 00: %r9                                                                         
> 00: [  424.586765] Call Trace:                                                  
> 00: [  424.586894]  [<000003ff80440dc2>] handle_pqap+0x2ba/0x468 [kvm]          
> 00: [  424.587026]  [<000003ff80446fa6>] kvm_s390_handle_b2+0x2f6/0x950 [kvm]   
> 00: [  424.587156]  [<000003ff8042d74c>] kvm_handle_sie_intercept+0x154/0x1db0 [
> 00: kvm]                                                                        
> 00: [  424.587287]  [<000003ff80426950>] __vcpu_run+0x1040/0x2150 [kvm]         
> 00: [  424.587414]  [<000003ff8042941a>] kvm_arch_vcpu_ioctl_run+0x5fa/0x1338 [k
> 00: vm]                                                                         
> 00: [  424.587540]  [<000003ff8040195e>] kvm_vcpu_ioctl+0x346/0xa10 [kvm]       
> 00: [  424.587590]  [<00000001433fbd16>] ksys_ioctl+0x276/0xbb8                 
> 00: [  424.587630]  [<00000001433fc682>] __s390x_sys_ioctl+0x2a/0x38            
> 00: [  424.587674]  [<000000014393c880>] system_call+0xd8/0x2b4                 
> 00: [  424.587715] 2 locks held by qemu-kvm/1533:                               
> 00: [  424.587748]  #0: 00000000822e80d0 (&vcpu->mutex){+.+.}-{3:3}, at: kvm_vcp
> 00: u_ioctl+0x170/0xa10 [kvm]                                                   
> 00: [  424.587898]  #1: 0000000081fe3980 (&kvm->srcu){....}-{0:0}, at: __vcpu_ru
> 00: n+0x60a/0x2150 [kvm]                                                        
> 00: [  424.588045] Last Breaking-Event-Address:                                 
> 00: [  424.588169]  [<000003ff80440c1e>] handle_pqap+0x116/0x468 [kvm]          
> 00: [  424.588204] irq event stamp: 23141                                       
> 00: [  424.588246] hardirqs last  enabled at (23149): [<000000014308f3de>] conso
> 00: le_unlock+0x766/0xa20                                                       
> 00: [  424.588287] hardirqs last disabled at (23156): [<000000014308ee40>] conso
> 00: le_unlock+0x1c8/0xa20                                                       
> 00: [  424.588536] softirqs last  enabled at (22998): [<000000014393e162>] __do_
> 00: softirq+0x6e2/0xa48                                                         
> 00: [  424.588583] softirqs last disabled at (22983): [<0000000142f652dc>] do_so
> 00: ftirq_own_stack+0xe4/0x100                                                  
> 00: [  424.588625] ---[ end trace e420441aa7c001ac ]---     
> 
