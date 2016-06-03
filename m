Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 3 Jun 2016 13:12:50 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [lockdep] chain_key collision check triggers
Message-ID: <20160603111250.GB3472@osiris>
References: <20160603071544.GA3472@osiris>
 <20160603084801.GG3190@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160603084801.GG3190@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alfredo Alvarez Fernandez <alfredoalvarezfernandez@gmail.com>, Ingo Molnar <mingo@kernel.org>, Shuah Khan <shuahkh@osg.samsung.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Jun 03, 2016 at 10:48:01AM +0200, Peter Zijlstra wrote:
> On Fri, Jun 03, 2016 at 09:15:44AM +0200, Heiko Carstens wrote:
> > Hi all,
> > 
> > the new lockdep chain_key collision detection code triggers quite reliably
> > on s390, so it looks like we need a different iterate_chain_key()
> > implementation?
> 
> That too, I have one queued up; but if you can realiably trigger this
> that's 'good' news. Most reports so far have been one offs that people
> could not reproduce.
> 
> Let me wake up a bit more, but in the meantime, the below is what I had
> queued.
> 
> ---
> Subject: locking,lockdep: Use __jhash_mix for iterate_chain_key
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Mon May 30 18:31:33 CEST 2016
> 
> Use __jhash_mix() to mix the class_idx into the class_key. This
> function provides better mixing than the previously used, home grown
> mix function.

Ok, thanks! I'll use that then. Unfortunately the new hash function
generates 28 instead of 2 instructions on s390.
