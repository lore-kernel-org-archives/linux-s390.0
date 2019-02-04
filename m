Return-Path: <SRS0=ZPcH=QL=vger.kernel.org=netdev-owner@kernel.org>
Date: Mon, 4 Feb 2019 09:46:58 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH] s390: bpf: fix JMP32 code-gen
Message-ID: <20190204174657.txmeyjiezdatwzyw@ast-mbp.dhcp.thefacebook.com>
References: <20190204154455.88687-1-heiko.carstens@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204154455.88687-1-heiko.carstens@de.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Jiong Wang <jiong.wang@netronome.com>, linux-s390@vger.kernel.org, netdev@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Feb 04, 2019 at 04:44:55PM +0100, Heiko Carstens wrote:
> Commit 626a5f66da0d19 ("s390: bpf: implement jitting of JMP32") added
> JMP32 code-gen support for s390. However it triggers the warning below
> due to some unusual gotos in the original s390 bpf jit code.
> 
> Add a couple of additional "is_jmp32" initializations to fix this.
> Also fix the wrong opcode for the "llilf" instruction that was
> introduced with the same commit.
> 
> arch/s390/net/bpf_jit_comp.c: In function 'bpf_jit_insn':
> arch/s390/net/bpf_jit_comp.c:248:55: warning: 'is_jmp32' may be used uninitialized in this function [-Wmaybe-uninitialized]
>   _EMIT6(op1 | reg(b1, b2) << 16 | (rel & 0xffff), op2 | mask); \
>                                                        ^
> arch/s390/net/bpf_jit_comp.c:1211:8: note: 'is_jmp32' was declared here
>    bool is_jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;
> 
> Fixes: 626a5f66da0d19 ("s390: bpf: implement jitting of JMP32")
> Cc: Jiong Wang <jiong.wang@netronome.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

Applied to bpf-next. Thanks!
