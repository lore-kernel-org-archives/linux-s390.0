Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53924 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726447AbgGVVGZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 22 Jul 2020 17:06:25 -0400
From: Schnelle <svens@linux.ibm.com>
Subject: Re: test_bpf regressions on s390 since 5.4
References: <20200716152306.GH3644@ubuntu-x1>
Date: Wed, 22 Jul 2020 23:01:17 +0200
In-Reply-To: <20200716152306.GH3644@ubuntu-x1> (seth forshee's message of
        "Thu, 16 Jul 2020 10:23:06 -0500")
Message-ID: <yt9dtuxzs1r6.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: seth.forshee@canonical.com
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Seth,

seth.forshee@canonical.com writes:

> The tests in lib/test_bpf.c were all passing in 5.4 when using the JIT,
> but some are failing in 5.7/5.8. Some of the failures are due to the
> removal of BPF_SIZE_MAX causing some expected failures to pass, which I
> have already send a patch for [1]. The remaining failures appear to be
> regressions. I haven't tried 5.5 or 5.6, so I'm not sure exactly when
> they first appeared.
>
> These are the tests which currently fail:
>
>  test_bpf: #37 INT: MUL_X jited:1 ret -1 != 1 FAIL (1 times)
>  test_bpf: #42 INT: SUB jited:1 ret -55 != 11 FAIL (1 times)
>  test_bpf: #44 INT: MUL jited:1 ret 439084800 != 903446258 FAIL (1 times)
>  test_bpf: #49 INT: shifts by register jited:1 ret -617 != -1 FAIL (1 times)
>  test_bpf: #371 JNE signed compare, test 1 jited:1 ret 2 != 1 FAIL (1 times)
>  test_bpf: #372 JNE signed compare, test 2 jited:1 ret 2 != 1 FAIL (1 times)
>  test_bpf: #374 JNE signed compare, test 4 jited:1 ret 1 != 2 FAIL (1 times)
>  test_bpf: #375 JNE signed compare, test 5 jited:1 ret 2 != 1 FAIL (1 times)

The problem seems to be that the s390 JIT code generates a clgfi (compare
logical 64 - 32 Bit) for JNE:

kernel: test_bpf: #37 INT: MUL_X 
bpf_jit: flen=8 proglen=66 pass=4 image=0000000035b17790 from=insmod pid=574
kernel: JIT code: 00000000: a7 f4 00 03 07 e0 eb bf f0 70 00 24 c0 e1 ff ff
kernel: JIT code: 00000010: ff ff c0 21 ff ff ff ff c0 31 00 00 00 03 b9 0c
kernel: JIT code: 00000020: 00 23 c2 2e ff ff ff fd a7 84 00 04 a7 f4 00 05
kernel: JIT code: 00000030: c0 e1 00 00 00 01 b9 04 00 2e eb bf f0 70 00 04
kernel: JIT code: 00000040: 07 fe
kernel: 000003ff800a0a48: a7f40003            brc        15,000003ff800a0a4e
kernel: 000003ff800a0a4c: 07e0                bcr        14,%r0
kernel: 000003ff800a0a4e: ebbff0700024        stmg       %r11,%r15,112(%r15)
kernel: 000003ff800a0a54: c0e1ffffffff        lgfi       %r14,-1
kernel: 000003ff800a0a5a: c021ffffffff        lgfi       %r2,-1
kernel: 000003ff800a0a60: c03100000003        lgfi       %r3,3
kernel: 000003ff800a0a66: b90c0023            msgr       %r2,%r3
kernel: 000003ff800a0a6a: c22efffffffd        clgfi      %r2,4294967293
kernel: 000003ff800a0a70: a7840004            brc        8,000003ff800a0a78
kernel: 000003ff800a0a74: a7f40005            brc        15,000003ff800a0a7e
kernel: 000003ff800a0a78: c0e100000001        lgfi       %r14,1
kernel: 000003ff800a0a7e: b904002e            lgr        %r2,%r14
kernel: 000003ff800a0a82: ebbff0700004        lmg        %r11,%r15,112(%r15)
kernel: 000003ff800a0a88: 07fe                bcr        15,%r14
kernel: jited:1 ret -1 != 1 FAIL (1 times)

which in the MUL_X case compares than 0xfffffffffffffffd with
0xfffffffd, which is wrong. Changing this to a proper compare fixes all
the test cases for me. Thanks for reporting!

Regards
Sven
