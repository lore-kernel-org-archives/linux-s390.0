Return-Path: <bpf-owner@vger.kernel.org>
Date: Tue, 26 Nov 2019 16:59:11 -0800 (PST)
From: Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [GIT PULL] seccomp updates for v5.5-rc1
In-Reply-To: <201911260818.9C5DC1E@keescook>
Message-ID: <alpine.DEB.2.21.9999.1911261656110.23039@viisi.sifive.com>
References: <201911260818.9C5DC1E@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: bpf-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, David Abdurachmanov <david.abdurachmanov@sifive.com>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>, bpf@vger.kernel.org, Christian Brauner <christian.brauner@ubuntu.com>, Daniel Borkmann <daniel@iogearbox.net>, kernel test robot <rong.a.chen@intel.com>, linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, linux-um@lists.infradead.org, Martin KaFai Lau <kafai@fb.com>, netdev@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Shuah Khan <shuah@kernel.org>, Song Liu <songliubraving@fb.com>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Tyler Hicks <tyhicks@canonical.com>, Will Drewry <wad@chromium.org>, x86@kernel.org, Yonghong Song <yhs@fb.com>

On Tue, 26 Nov 2019, Kees Cook wrote:

> Most notably, the secure_computing() prototype has changed (to remove an 
> unused argument), but this has happened at the same time as riscv adding 
> seccomp support, so the cleanest merge order would be to merge riscv 
> first, then seccomp with the following patch for riscv to handle the 
> change from "seccomp: simplify secure_computing()":

The RISC-V pull request that contains the seccomp change has been sent.  
It's here:

https://lore.kernel.org/linux-riscv/alpine.DEB.2.21.9999.1911261311520.23039@viisi.sifive.com/T/#u


- Paul
