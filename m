Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FACC6FA8A
	for <linux-s390@archiver.kernel.org>; Wed, 14 Sep 2022 09:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiINJvd (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 14 Sep 2022 05:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiINJvb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 14 Sep 2022 05:51:31 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D26642E9
        for <linux-s390@vger.kernel.org>; Wed, 14 Sep 2022 02:51:29 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E9ag5v009463;
        Wed, 14 Sep 2022 09:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=rEETOHTkXpQdk4kRE+9fh4p17aULQ0dCHgBH4VuXt/k=;
 b=fhiftanOy2cZj9r3snAuaelsFMpP67cVCTrupxgKM2KeDOIHS0COVWjihH47DIqCGRlG
 +MrLucGxSF8Tccpb8B6O4ZwbWfjYsX/DdrkNXfXFLxyIdAG/NjNw7Vf13wRMd4WvCkUF
 T+PXyVsQKytNoVbFlqWFTHN2t8zVeJJK+9bxPIAeXowWJUrOvy/4qrzmUdM9yVv6RL0n
 uwmFZSc6YC705tbNZNZ8yKlwMrCLpN6v6VfPaDBLJzBcc9nvtwFUQ3FK3a1GCtZIYlK7
 yWp0SQwZcRvLeKdEzYlLrXL3qmHIWpUxSy5ART08tQfKVKwrzOWd3gUN0XE/+1UONwQS sA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jkc7g8s1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 09:50:59 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28E9bMeN017335;
        Wed, 14 Sep 2022 09:50:59 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jkc7g8s09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 09:50:59 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28E9oqFa000358;
        Wed, 14 Sep 2022 09:50:57 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3jjytx0su4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 09:50:56 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28E9l8bj14549322
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 09:47:08 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6D414C046;
        Wed, 14 Sep 2022 09:50:53 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 608034C040;
        Wed, 14 Sep 2022 09:50:53 +0000 (GMT)
Received: from [9.171.58.180] (unknown [9.171.58.180])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 14 Sep 2022 09:50:53 +0000 (GMT)
Message-ID: <ffeb23b0-f377-a40f-a6c1-3d14154713f3@linux.ibm.com>
Date:   Wed, 14 Sep 2022 11:50:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: Illegal operation with clang + CONFIG_MARCH_Z13
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, llvm@lists.linux.dev,
        qemu-s390x <qemu-s390x@nongnu.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Richard Henderson <rth@twiddle.net>,
        David Hildenbrand <david@redhat.com>
References: <YyC/JvFONhtTYjM/@dev-arch.thelio-3990X>
 <ed01ea25-7abd-4564-0a9d-ad8b0cb9f1b4@linux.ibm.com>
 <YyGYO0mmNzMYgF9d@dev-arch.thelio-3990X>
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <YyGYO0mmNzMYgF9d@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9Zyq-saOyawSuMlSmT2aNDH3nJ2HVwtX
X-Proofpoint-ORIG-GUID: dEOKKdm9KRwkQNhqVFpqI9RenNVqNGM5
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_03,2022-09-14_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140046
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Am 14.09.22 um 11:00 schrieb Nathan Chancellor:
> On Wed, Sep 14, 2022 at 08:03:47AM +0200, Christian Borntraeger wrote:
>> Am 13.09.22 um 19:34 schrieb Nathan Chancellor:
>>> Hi all,
>>>
>>> Recently, Fedora moved their baseline from CONFIG_MARCH_ZEC12 to
>>> CONFIG_MARCH_Z13:
>>>
>>> https://src.fedoraproject.org/rpms/kernel/c/aff6e8acdaa437e9f06ef4166ca2209071223f8d
>>>
>>> Unfortunately, this causes clang built kernels to have an "illegal
>>> operation" panic when booting in QEMU. This is trivially reproducible on
>>> mainline with the versions of clang that s390 supports.
>>>
>>> # Switch from CONFIG_MARCH_ZEC12 to CONFIG_MARCH_Z13
>>> $ make -skj"$(nproc)" ARCH=s390 CC=clang CROSS_COMPILE=s390x-linux-gnu- defconfig menuconfig bzImage
>>>
>>> $ qemu-system-s390x \
>>> -M s390-ccw-virtio \
>>> -kernel arch/s390/boot/bzImage \
>>> -display none \
>>> -initrd .../boot-utils/images/s390/rootfs.cpio \
>>> -m 512m \
>>> -nodefaults \
>>> -no-reboot \
>>> -serial mon:stdio
>>> ...
>>> [    0.558817] Linux version 6.0.0-rc5-00017-gd1221cea11fc (nathan@distrobox-oTN5YGrt3J.thelio-3990X) (clang version 14.0.5 (Fedora 14.0.5-7.fc38), GNU ld version 2.38-4.fc37) #1 SMP Tue Sep 13 08:35:38 MST 2022
>>> ...
>>> [    1.675787] illegal operation: 0001 ilc:3 [#1] SMP
>>> [    1.675888] Modules linked in:
>>> [    1.676044] CPU: 0 PID: 59 Comm: modprobe Not tainted 6.0.0-rc5-00017-gd1221cea11fc #1
>>> [    1.676134] Hardware name: QEMU 8561 QEMU (KVM/Linux)
>>
>> What qemu version is that and what command line did you use (any cpu model?)
> 
> I was able to reproduce this with QEMU 6.0.0 through 7.1.0, which are
> the versions that can boot a clang built kernel. I don't think we
> specify a cpu model, you can see the full command above. If there is
> something we should be doing differently, please let us know!
> 
>>> [    1.676202] Krnl PSW : 0704d00180000000 0000000000579fbc (load_elf_binary+0x31c/0x11c0)
>>> [    1.676459]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
>>> [    1.676489] Krnl GPRS: 0000000000000001 00000000044f0000 0000000000000000 0000000000000000
>>> [    1.676506]            8000000000000080 0000000000000000 0000000000000000 00000000035fa900
>>> [    1.676522]            0000000000000001 000000000353ce00 0000000000000001 00000000044693c0
>>> [    1.676538]            000000000276fa00 000000000446a000 0000000000579f9e 00000380002ebc78
>>> [    1.677128] Krnl Code: 0000000000579fac: a7f405b8            brc     15,000000000057ab1c
>>> [    1.677128]            0000000000579fb0: e31003400004        lg      %r1,832
>>> [    1.677128]           #0000000000579fb6: e3001780003b        lzrf    %r0,1920(%r1)
>>
>> QEMU does support lzrf as far asI can tell as soon as you have S390_FEAT_STFLE_53 which is part
>> of the qemu_V4_1 cpu model.
>>
>>> [    1.677128]           >0000000000579fbc: 50001780            st      %r0,1920(%r1)
>>> [    1.677128]            0000000000579fc0: e31003400004        lg      %r1,832
>>> [    1.677128]            0000000000579fc6: c40800aa99a9        lgrl    %r0,0000000001acd318
>>> [    1.677128]            0000000000579fcc: e3001d400124        stg     %r0,7488(%r1)
>>> [    1.677128]            0000000000579fd2: e31003400004        lg      %r1,832


Can you check if the following qemu patch helps?

diff --git a/target/s390x/tcg/insn-data.def b/target/s390x/tcg/insn-data.def
index 5e448bb2c488..6bb479340a38 100644
--- a/target/s390x/tcg/insn-data.def
+++ b/target/s390x/tcg/insn-data.def
@@ -466,7 +466,7 @@
      C(0xe39f, LAT,     RXY_a, LAT, 0, m2_32u, r1, 0, lat, 0)
      C(0xe385, LGAT,    RXY_a, LAT, 0, a2, r1, 0, lgat, 0)
  /* LOAD AND ZERO RIGHTMOST BYTE */
-    C(0xe3eb, LZRF,    RXY_a, LZRB, 0, m2_32u, new, r1_32, lzrb, 0)
+    C(0xe33b, LZRF,    RXY_a, LZRB, 0, m2_32u, new, r1_32, lzrb, 0)
      C(0xe32a, LZRG,    RXY_a, LZRB, 0, m2_64, r1, 0, lzrb, 0)
  /* LOAD LOGICAL AND ZERO RIGHTMOST BYTE */
      C(0xe33a, LLZRGF,  RXY_a, LZRB, 0, m2_32u, r1, 0, lzrb, 0)

