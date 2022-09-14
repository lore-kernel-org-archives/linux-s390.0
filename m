Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2433ECAAD8
	for <linux-s390@archiver.kernel.org>; Wed, 14 Sep 2022 06:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiINGET (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 14 Sep 2022 02:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiINGEN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 14 Sep 2022 02:04:13 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685BC6F25D
        for <linux-s390@vger.kernel.org>; Tue, 13 Sep 2022 23:04:12 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E5sB1n031730;
        Wed, 14 Sep 2022 06:03:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=c3TMST96tr8RiD0Hwhnty/VtybKhf2kU2QGhaBAJTPo=;
 b=sMzGTHh8L/xsLepJsS6rl9jvMTKD4OOgkcxqWmDQ3PgdRDl3nUrsNOAAFib1GGqQjJxa
 H7f8YJz2Lgw1HMVwCTbcoGyL9EyQMpl4OPdk9yRMuu1JnQ2Iv5cu3TMDBMvNCOOLttx7
 YztQF2D3RLIljnSj8uHyWQ+BFAzfW7IOy1wfGUoEGUv84DSuQ1+U9Sf90ytR64qsZPL7
 yYb7pIyGiPDA9LzciHsS+Z1LYndInI50kZr+MwW9M4Mu/vkCAeYmCAMvmlQzrXsPahnz
 5clYWeBnoEImMsBGGH/FlZVMJn33P8hwOnE5004Fi1nLI14rQKhJZ6F9lped1VNHXD9L Ig== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jk97d8740-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 06:03:54 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28E5pZcl005273;
        Wed, 14 Sep 2022 06:03:51 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 3jjy2n0dnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 06:03:51 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28E63mio42205568
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 06:03:48 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D0194C044;
        Wed, 14 Sep 2022 06:03:48 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BB534C046;
        Wed, 14 Sep 2022 06:03:48 +0000 (GMT)
Received: from [9.171.58.180] (unknown [9.171.58.180])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 14 Sep 2022 06:03:48 +0000 (GMT)
Message-ID: <ed01ea25-7abd-4564-0a9d-ad8b0cb9f1b4@linux.ibm.com>
Date:   Wed, 14 Sep 2022 08:03:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: Illegal operation with clang + CONFIG_MARCH_Z13
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        llvm@lists.linux.dev, qemu-s390x <qemu-s390x@nongnu.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
References: <YyC/JvFONhtTYjM/@dev-arch.thelio-3990X>
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <YyC/JvFONhtTYjM/@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: q-94n5R_4dOwPTV-gVSWCPcoPIZnQLaO
X-Proofpoint-GUID: q-94n5R_4dOwPTV-gVSWCPcoPIZnQLaO
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_02,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2208220000
 definitions=main-2209140029
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Am 13.09.22 um 19:34 schrieb Nathan Chancellor:
> Hi all,
> 
> Recently, Fedora moved their baseline from CONFIG_MARCH_ZEC12 to
> CONFIG_MARCH_Z13:
> 
> https://src.fedoraproject.org/rpms/kernel/c/aff6e8acdaa437e9f06ef4166ca2209071223f8d
> 
> Unfortunately, this causes clang built kernels to have an "illegal
> operation" panic when booting in QEMU. This is trivially reproducible on
> mainline with the versions of clang that s390 supports.
> 
> # Switch from CONFIG_MARCH_ZEC12 to CONFIG_MARCH_Z13
> $ make -skj"$(nproc)" ARCH=s390 CC=clang CROSS_COMPILE=s390x-linux-gnu- defconfig menuconfig bzImage
> 
> $ qemu-system-s390x \
> -M s390-ccw-virtio \
> -kernel arch/s390/boot/bzImage \
> -display none \
> -initrd .../boot-utils/images/s390/rootfs.cpio \
> -m 512m \
> -nodefaults \
> -no-reboot \
> -serial mon:stdio
> ...
> [    0.558817] Linux version 6.0.0-rc5-00017-gd1221cea11fc (nathan@distrobox-oTN5YGrt3J.thelio-3990X) (clang version 14.0.5 (Fedora 14.0.5-7.fc38), GNU ld version 2.38-4.fc37) #1 SMP Tue Sep 13 08:35:38 MST 2022
> ...
> [    1.675787] illegal operation: 0001 ilc:3 [#1] SMP
> [    1.675888] Modules linked in:
> [    1.676044] CPU: 0 PID: 59 Comm: modprobe Not tainted 6.0.0-rc5-00017-gd1221cea11fc #1
> [    1.676134] Hardware name: QEMU 8561 QEMU (KVM/Linux)

What qemu version is that and what command line did you use (any cpu model?)

> [    1.676202] Krnl PSW : 0704d00180000000 0000000000579fbc (load_elf_binary+0x31c/0x11c0)
> [    1.676459]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
> [    1.676489] Krnl GPRS: 0000000000000001 00000000044f0000 0000000000000000 0000000000000000
> [    1.676506]            8000000000000080 0000000000000000 0000000000000000 00000000035fa900
> [    1.676522]            0000000000000001 000000000353ce00 0000000000000001 00000000044693c0
> [    1.676538]            000000000276fa00 000000000446a000 0000000000579f9e 00000380002ebc78
> [    1.677128] Krnl Code: 0000000000579fac: a7f405b8            brc     15,000000000057ab1c
> [    1.677128]            0000000000579fb0: e31003400004        lg      %r1,832
> [    1.677128]           #0000000000579fb6: e3001780003b        lzrf    %r0,1920(%r1)

QEMU does support lzrf as far asI can tell as soon as you have S390_FEAT_STFLE_53 which is part
of the qemu_V4_1 cpu model.

> [    1.677128]           >0000000000579fbc: 50001780            st      %r0,1920(%r1)
> [    1.677128]            0000000000579fc0: e31003400004        lg      %r1,832
> [    1.677128]            0000000000579fc6: c40800aa99a9        lgrl    %r0,0000000001acd318
> [    1.677128]            0000000000579fcc: e3001d400124        stg     %r0,7488(%r1)
> [    1.677128]            0000000000579fd2: e31003400004        lg      %r1,832
> [    1.677343] Call Trace:
> [    1.677564]  [<0000000000579fbc>] load_elf_binary+0x31c/0x11c0
> [    1.677635] ([<0000000000579f9e>] load_elf_binary+0x2fe/0x11c0)
> [    1.677652]  [<00000000004e1ae6>] bprm_execve+0x4f6/0x7b0
> [    1.677671]  [<00000000004e1256>] kernel_execve+0x3b6/0x3d0
> [    1.677687]  [<000000000017e1c8>] call_usermodehelper_exec_async+0x158/0x1d0
> [    1.677706]  [<0000000000103a9a>] __ret_from_fork+0x3a/0x60
> [    1.677719]  [<0000000000f8562a>] ret_from_fork+0xa/0x40
> [    1.677748] Last Breaking-Event-Address:
> [    1.677757]  [<0000000000579fa2>] load_elf_binary+0x302/0x11c0
> [    1.678012] Kernel panic - not syncing: Fatal exception: panic_on_oops
> 
> The rootfs image is available in our boot-utils repo [1], should it be
> necessary for reproducing this issue. I do not see any problems with
> booting a CONFIG_MARCH_Z13 kernel compiled with GCC 12.2.1 from Fedora
> but it is possible that clang and GCC generate different code. I am not
> sure if this is a compiler problem or an emulation one, which is where I
> was looking for some input from you all.
> 
> [1]: https://github.com/ClangBuiltLinux/boot-utils
> 
> Cheers,
> Nathan
