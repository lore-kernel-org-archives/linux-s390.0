Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20190919150314.054351477@linutronix.de>
In-Reply-To: <20190919150314.054351477@linutronix.de>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 23 Sep 2019 11:18:33 -0700
Message-ID: <CALCETrVpG9iH821LMuL5OOrAeRekYjYE9fyK3KkCwohN6ZUcXg@mail.gmail.com>
Subject: Re: [RFC patch 00/15] entry: Provide generic implementation for host
 and guest entry/exit work
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm list <kvm@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

On Thu, Sep 19, 2019 at 8:09 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> When working on a way to move out the posix cpu timer expiry out of the
> timer interrupt context, I noticed that KVM is not handling pending task
> work before entering a guest. A quick hack was to add that to the x86 KVM
> handling loop. The discussion ended with a request to make this a generic
> infrastructure possible with also moving the per arch implementations of
> the enter from and return to user space handling generic.
>
>   https://lore.kernel.org/r/89E42BCC-47A8-458B-B06A-D6A20D20512C@amacapital.net
>
> You asked for it, so don't complain that you have to review it :)
>
> The series implements the syscall enter/exit and the general exit to
> userspace work handling along with the pre guest enter functionality.
>
> The series converts x86 and ARM64. x86 is fully tested including selftests
> etc. ARM64 is only compile tested for now as my only ARM64 testbox is not
> available right now.

Other than the comments I sent so far, I like this series.
