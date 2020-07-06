Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44082 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728321AbgGFIz5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Jul 2020 04:55:57 -0400
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: Re: bpf: bpf_probe_read helper restriction on s390x
Date: Mon,  6 Jul 2020 10:54:56 +0200
Message-Id: <20200706085456.48306-1-sumanthk@linux.ibm.com>
In-Reply-To: <20200705194225.GB3356590@krava>
References: <20200705194225.GB3356590@krava>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: jolsa@redhat.com
Cc: Sumanth.Korikkar@ibm.com, sumanthk@linux.ibm.com, agordeev@linux.ibm.com, ast@kernel.org, bas@baslab.org, bpf@vger.kernel.org, brendan.d.gregg@gmail.com, daniel@iogearbox.net, dxu@dxuuu.xyz, linux-s390@vger.kernel.org, mat@mmarchini.me, netdev@vger.kernel.org, yauheni.kaliuta@redhat.com

Hi Jiri,

Sorry about the noise. My email seems to be rejected to the list. Resending
with plain text.

s390 has overlapping address space. As suggested by the commit,
ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE should not be enabled for s390 kernel.
This should be changed in bpftrace application.

Even if we enable ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE, bpf_probe_read will
only work in certain cases like kernel pointer deferences (kprobes).  User
pointer deferences in uprobes/kprobes/etc will fail or have some invalid data

I am looking forward to this fix: https://github.com/iovisor/bpftrace/pull/1141
OR probe split in bpftrace.

Thank you

Best Regards
Sumanth
