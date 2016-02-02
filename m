From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 1/5] all: s390: move wrapper infrastructure to generic
 headers
Date: Tue, 2 Feb 2016 20:54:34 +0100
Message-ID: <20160202195434.GA3397@osiris>
References: <1453741047-5498-1-git-send-email-ynorov@caviumnetworks.com>
 <1453741047-5498-2-git-send-email-ynorov@caviumnetworks.com>
 <20160128121618.GB5418@osiris>
 <20160128163109.GA8529@yury-N73SV>
 <20160201114251.GB973@yury-N73SV>
 <20160202073913.GB3990@osiris>
 <20160202154331.GA3003@yury-N73SV>
 <20160202160826.GF3990@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160202160826.GF3990@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, arnd@arndb.de, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, catalin.marinas@arm.com, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, agraf@suse.de, klimov.linux@gmail.com, broonie@kernel.org, joseph@codesourcery.com, schwidefsky@de.ibm.com, linux-arm-kernel@lists.infradead.org, christoph.muellner@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

Hi Yury,

On Tue, Feb 02, 2016 at 05:08:26PM +0100, Heiko Carstens wrote:
> See e.g. 485d52768685 ("sys_personality: change sys_personality() to accept
> "unsigned int" instead of u_long") would have been a candidate which could
> silently break architectures which need compat wrappers.

Ok, this example is of course wrong. But now I can claim that also somebody
who should know better makes these mistakes.. :)

> > I don't know much about s390 specifics. Maybe because of that I do not
> > understand completely your worries. I'm OK with both 1st and 2nd
> > version, but I'd choose 2nd one because it allows inlines, and we
> > don't need the compat_wrapper.c.
> 
> It would be only nicer if we can guarentee correctness all the time. That
> being said I'm about to revert my own commit :)
> 
> So if you want to go without compat_wrapper.c then we should have a
> solution which will do the right thing all the time without that a system
> call author has to know about the sign and zero extension issue some
> architectures face. It _will_ go wrong.

So I think I can summarize my point to: if you can enforce correctness, why
shouldn't you do it if the performance impact is only a single instruction.

However I'll try to write an addon patch to your patch series. Maybe we can
still get rid of compat_wrapper.c in a way which makes both of us happy.
Also.. the idea with the alias names for compat wrappers does seem to have
the disadvantage that it will pollute /proc/kallsyms for example.

Anyway, I'm not sure if I will be able to come up with something this week
though.
