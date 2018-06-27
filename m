From: Kleber Souza <kleber.souza@canonical.com>
Subject: s390x BPF JIT failures with test_bpf
Date: Wed, 27 Jun 2018 11:40:23 +0200
Message-ID: <6a515d91-e831-e240-1ae6-ff0d6ead6cf2@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: linux-s390@vger.kernel.org, netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
List-ID: <linux-s390.vger.kernel.org>

Hi,

When I load the test_bpf module from mainline (v4.18-rc2) with
CONFIG_BPF_JIT_ALWAYS_ON=y on a s390x system I get the following errors:

test_bpf: #289 BPF_MAXINSNS: Ctx heavy transformations FAIL to
prog_create err=-524 len=4096
test_bpf: #290 BPF_MAXINSNS: Call heavy transformations FAIL to
prog_create err=-524 len=4096
[...]
test_bpf: #296 BPF_MAXINSNS: exec all MSH FAIL to prog_create err=-524
len=4096
test_bpf: #297 BPF_MAXINSNS: ld_abs+get_processor_id FAIL to prog_create
err=-524 len=4096

From a quick look at the code it seems that
arch/s390/net/bpf_jit_comp.c:bpf_int_jit_compile() is failing to JIT
compile the test code.

Are those failures expected and could be flagged with FLAG_EXPECTED_FAIL
on lib/test_bpf.c or are those caused by some issue with the s390x JIT
compiler that needs to be fixed?


Thanks,
Kleber
