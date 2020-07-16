Return-Path: <bpf-owner@vger.kernel.org>
Date: Thu, 16 Jul 2020 10:23:06 -0500
From: seth.forshee@canonical.com
Subject: test_bpf regressions on s390 since 5.4
Message-ID: <20200716152306.GH3644@ubuntu-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: bpf-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

The tests in lib/test_bpf.c were all passing in 5.4 when using the JIT,
but some are failing in 5.7/5.8. Some of the failures are due to the
removal of BPF_SIZE_MAX causing some expected failures to pass, which I
have already send a patch for [1]. The remaining failures appear to be
regressions. I haven't tried 5.5 or 5.6, so I'm not sure exactly when
they first appeared.

These are the tests which currently fail:

 test_bpf: #37 INT: MUL_X jited:1 ret -1 != 1 FAIL (1 times)
 test_bpf: #42 INT: SUB jited:1 ret -55 != 11 FAIL (1 times)
 test_bpf: #44 INT: MUL jited:1 ret 439084800 != 903446258 FAIL (1 times)
 test_bpf: #49 INT: shifts by register jited:1 ret -617 != -1 FAIL (1 times)
 test_bpf: #371 JNE signed compare, test 1 jited:1 ret 2 != 1 FAIL (1 times)
 test_bpf: #372 JNE signed compare, test 2 jited:1 ret 2 != 1 FAIL (1 times)
 test_bpf: #374 JNE signed compare, test 4 jited:1 ret 1 != 2 FAIL (1 times)
 test_bpf: #375 JNE signed compare, test 5 jited:1 ret 2 != 1 FAIL (1 times)

Thanks,
Seth

[1] https://lore.kernel.org/lkml/20200716143931.330122-1-seth.forshee@canonical.com/
