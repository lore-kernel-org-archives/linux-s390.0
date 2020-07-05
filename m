Return-Path: <bpf-owner@vger.kernel.org>
Date: Sun, 5 Jul 2020 21:42:25 +0200
From: Jiri Olsa <jolsa@redhat.com>
Subject: bpf: bpf_probe_read helper restriction on s390x
Message-ID: <20200705194225.GB3356590@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: bpf-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, Sumanth Korikkar <Sumanth.Korikkar@ibm.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Alexander Gordeev <agordeev@linux.ibm.com>, Yauheni Kaliuta <yauheni.kaliuta@redhat.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, Brendan Gregg <brendan.d.gregg@gmail.com>, bas@baslab.org, Matheus Marchini <mat@mmarchini.me>, Daniel Xu <dxu@dxuuu.xyz>

hi,
with following commit:
  0ebeea8ca8a4 bpf: Restrict bpf_probe_read{, str}() only to archs where they work

the bpf_probe_read BPF helper is restricted on architectures that
have 'non overlapping address space' and select following config:

   select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE

there's also nice explanation in this commit's changelog:
  6ae08ae3dea2 bpf: Add probe_read_{user, kernel} and probe_read_{user, kernel}_str helpers


We have a problem with bpftrace not working properly on s390x because
bpf_probe_read is no longer available, and bpftrace does not use
bpf_probe_read_(user/kernel) variants yet.

My question is if s390x is 'arch with overlapping address space' and we
could fix this by adding ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE for s390x
or we need to fix bpftrace to detect this, which we probably need to do
in any case ;-)

thanks,
jirka
