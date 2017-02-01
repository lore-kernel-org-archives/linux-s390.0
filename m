Return-Path: <mbenes@suse.cz>
Date: Wed, 1 Feb 2017 21:52:44 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v4 00/15] livepatch: hybrid consistency model
In-Reply-To: <20170201200243.zqxq6lmbjsr6in52@treble>
Message-ID: <alpine.LSU.2.20.1702012145180.29670@pobox.suse.cz>
References: <cover.1484839971.git.jpoimboe@redhat.com>
 <20170201200243.zqxq6lmbjsr6in52@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 1 Feb 2017, Josh Poimboeuf wrote:

> On Thu, Jan 19, 2017 at 09:46:08AM -0600, Josh Poimboeuf wrote:
> > Here's v4, based on linux-next/master.  Mostly minor changes this time,
> > primarily due to Petr's v3 comments.
> 
> So far, the only review comments have been related to the first patch,
> of which I just posted an updated version.

Yes, I'm really sorry about that. I'm going through the main patch of the 
series (13/15) and it's slow to explore all details. I know Petr is in the 
process too (and I think he has found some issues. He'll speak up.).
 
> If there are no more comments, it would be great to get these patches in
> for the 4.11 merge window.  Any objections to that?

That would be nice but I don't think it's realistic. The merge window is 
quite close and we still need to finish the review and get some Acks - 
at least arch maintainers and PeterZ and/or Ingo for rq lock.

It would be great to keep in next- for a while (one cycle) too.

Miroslav
