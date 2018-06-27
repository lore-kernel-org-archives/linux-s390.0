From: Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: s390x BPF JIT failures with test_bpf
Date: Wed, 27 Jun 2018 12:36:23 +0200
Message-ID: <0511ac38-beec-131f-5643-04eee3357cc4@iogearbox.net>
References: <6a515d91-e831-e240-1ae6-ff0d6ead6cf2@canonical.com>
 <33983d2e-905b-e05b-67e3-11eb9bc6f030@iogearbox.net>
 <908de5ba-3a65-dfa1-3d5e-de25b4e984a2@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <908de5ba-3a65-dfa1-3d5e-de25b4e984a2@canonical.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: Kleber Souza <kleber.souza@canonical.com>, linux-s390@vger.kernel.org, netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 06/27/2018 12:13 PM, Kleber Souza wrote:
> On 06/27/18 12:01, Daniel Borkmann wrote:
>> On 06/27/2018 11:40 AM, Kleber Souza wrote:
>> [...]
>>> When I load the test_bpf module from mainline (v4.18-rc2) with
>>> CONFIG_BPF_JIT_ALWAYS_ON=y on a s390x system I get the following errors:
>>>
>>> test_bpf: #289 BPF_MAXINSNS: Ctx heavy transformations FAIL to
>>> prog_create err=-524 len=4096
>>> test_bpf: #290 BPF_MAXINSNS: Call heavy transformations FAIL to
>>> prog_create err=-524 len=4096
>>> [...]
>>> test_bpf: #296 BPF_MAXINSNS: exec all MSH FAIL to prog_create err=-524
>>> len=4096
>>> test_bpf: #297 BPF_MAXINSNS: ld_abs+get_processor_id FAIL to prog_create
>>> err=-524 len=4096
>>>
>>> From a quick look at the code it seems that
>>> arch/s390/net/bpf_jit_comp.c:bpf_int_jit_compile() is failing to JIT
>>> compile the test code.
>>>
>>> Are those failures expected and could be flagged with FLAG_EXPECTED_FAIL
>>> on lib/test_bpf.c or are those caused by some issue with the s390x JIT
>>> compiler that needs to be fixed?
>>
>> JIT doesn't guarantee in general to map really all programs to native insns,
>> so some, mostly crafted corner cases could fail. E.g. x86-64 JIT doesn't converge
>> on some programs in test_bpf.c and thus falls back to interpreter or simply
>> rejects the program in case of CONFIG_BPF_JIT_ALWAYS_ON=y. Above would seem
>> likely that it's hitting the BPF_SIZE_MAX that s390 would do. I think it might
>> make sense to either have the FLAG_EXPECTED_FAIL in lib/test_bpf.c more fine
>> grained as a flag per arch, so we could say it's expected to fail on e.g. s390
>> but not on x86 and the like, or just denote it as 'could potentially fail but
>> doesn't have to be the case everywhere'.
> 
> Thank you for your reply. I will run some more tests to make sure we are
> hitting BPF_SIZE_MAX or what exactly is failing and send a patch to flag
> it conditionally for s390x.

Sounds good, thanks! In any case, please let us know your findings.

Best,
Daniel
