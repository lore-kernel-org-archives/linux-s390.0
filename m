Return-Path: <pmladek@suse.com>
Date: Thu, 2 Feb 2017 15:37:37 +0100
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v4 00/15] livepatch: hybrid consistency model
Message-ID: <20170202143737.GD23754@pathway.suse.cz>
References: <cover.1484839971.git.jpoimboe@redhat.com>
 <20170201200243.zqxq6lmbjsr6in52@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170201200243.zqxq6lmbjsr6in52@treble>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed 2017-02-01 14:02:43, Josh Poimboeuf wrote:
> On Thu, Jan 19, 2017 at 09:46:08AM -0600, Josh Poimboeuf wrote:
> > Here's v4, based on linux-next/master.  Mostly minor changes this time,
> > primarily due to Petr's v3 comments.
> 
> So far, the only review comments have been related to the first patch,
> of which I just posted an updated version.
> 
> If there are no more comments, it would be great to get these patches in
> for the 4.11 merge window.  Any objections to that?

I have finished the review finally. We still need to address some
issues but I think that we are much more close now. I found only
few small problems. Othewise, the consistency handling looks pretty
consistent to me :-)

Best Regards,
Petr
