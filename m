From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: Is THREAD_INFO_IN_TASK appropriate for -mm for 4.8?
Date: Tue, 19 Jul 2016 10:25:42 +0200
Message-ID: <578DE406.9060902@de.ibm.com>
References: <CALCETrUf_7=Tr4JrDj+3UPT5kUT1MsRtypvfqkOg_MVHAJu=PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <CALCETrUf_7=Tr4JrDj+3UPT5kUT1MsRtypvfqkOg_MVHAJu=PA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, x86 <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Linux Arch Mailing List <linux-arch@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On 07/19/2016 01:47 AM, Andy Lutomirski wrote:
> Hi all-
> 
> There are four core patches needed for the THREAD_INFO_IN_TASK thing,
> and they apply cleanly to -mm now.  The x86 patch to flip the feature
> on does not apply cleanly anywhere because it depends on changes in
> -tip *and* in -mm.  I'd like to get all of this as well as the rest of
> the vmap-stacks stuff in by 4.9, but I'm wondering if it might make
> sense to get the core THREAD_INFO_IN_TASK stuff into -mm for 4.8
> instead.
> 
> Pros:
>  - It reduces the amount of core code that -tip will have to carry until 4.9.
>  - It may benefit other architectures.  Christian Borntraeger
> expressed an interest in enabling the feature for s390, but it'll be
> awkward for him until the core bit landed.  Similarly, arm64 seems to
> be interested.

I have not yet talked to Martin/Heiko about this, so not sure yet if and when
s390 is going to use this - so no pressure from our side yet.
