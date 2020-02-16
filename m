Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52609 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726037AbgBPS6H (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 16 Feb 2020 13:58:07 -0500
Received: by mail-qk1-f199.google.com with SMTP id e11so10415351qkl.8
        for <linux-s390@vger.kernel.org>; Sun, 16 Feb 2020 10:58:02 -0800 (PST)
Date: Sun, 16 Feb 2020 13:57:59 -0500
From: Jeremy Cline <jcline@redhat.com>
Subject: Re: s390 depending on cc-options makes it difficult to configure
Message-ID: <20200216185759.GA4091960@dev.jcline.org>
References: <20191209164155.GA78160@dev.jcline.org>
 <20191210090108.GA22512@unicorn.suse.cz>
 <20191211171822.GA36366@dev.jcline.org>
 <20200210194936.511ef603@laptop2-ibm.local>
 <CAK7LNATL3Oyn=FLKm0TcB9SkJLuCOWV06a_t-FRtFiFp9Vda1g@mail.gmail.com>
 <20200214203536.GA133402@laptop.jcline.org>
 <CAK7LNAQ9+n8eRyUVrqTNDu915VcE+uHQoewH8WzJqpOpi8rT0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQ9+n8eRyUVrqTNDu915VcE+uHQoewH8WzJqpOpi8rT0Q@mail.gmail.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Philipp Rudo <prudo@linux.ibm.com>, Michal Kubecek <mkubecek@suse.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>

On Sun, Feb 16, 2020 at 01:08:49PM +0900, Masahiro Yamada wrote:
> On Sat, Feb 15, 2020 at 5:35 AM Jeremy Cline <jcline@redhat.com> wrote:
> >
> > On Fri, Feb 14, 2020 at 12:31:05PM +0900, Masahiro Yamada wrote:
> > > Hi.
> > >
> > > On Tue, Feb 11, 2020 at 3:49 AM Philipp Rudo <prudo@linux.ibm.com> wrote:
> > > >
> > > > Hey Jeremy,
> > > > Hey Michal,
> > > >
> > > > sorry for the late response. The mail got lost in the pre-xmas rush...
> > > >
> > > > In my opinion the problem goes beyond s390 and the commit you mentioned. So I'm
> > > > also adding Masahiro as Kconfig maintainer and author of cc-option.
> > >
> > >
> > > I did not notice the former discussion.
> > > Thanks for CC'ing me.
> > >
> > >
> > >
> > >
> > > > On Wed, 11 Dec 2019 12:18:22 -0500
> > > > Jeremy Cline <jcline@redhat.com> wrote:
> > > >
> > > > > On Tue, Dec 10, 2019 at 10:01:08AM +0100, Michal Kubecek wrote:
> > > > > > On Mon, Dec 09, 2019 at 11:41:55AM -0500, Jeremy Cline wrote:
> > > > > > > Hi folks,
> > > > > > >
> > > > > > > Commit 5474080a3a0a ("s390/Kconfig: make use of 'depends on cc-option'")
> > > > > > > makes it difficult to produce an s390 configuration for Fedora and Red
> > > > > > > Hat kernels.
> > > > > > >
> > > > > > > The issue is I have the following configurations:
> > > > > > >
> > > > > > > CONFIG_MARCH_Z13=y
> > > > > > > CONFIG_TUNE_Z14=y
> > > > > > > # CONFIG_TUNE_DEFAULT is not set
> > > > > > >
> > > > > > > When the configuration is prepared on a non-s390x host without a
> > > > > > > compiler with -march=z* it changes CONFIG_TUNE_DEFAULT to y which, as
> > > > > > > far as I can tell, leads to a kernel tuned for z13 instead of z14.
> > > > > > > Fedora and Red Hat build processes produce complete configurations from
> > > > > > > snippets on any available host in the build infrastructure which very
> > > > > > > frequently is *not* s390.
> > > > > >
> > > > > > We have exactly the same problem. Our developers need to update config
> > > > > > files for different architectures and different kernel versions on their
> > > > > > machines which are usually x86_64 but that often produces different
> > > > > > configs than the real build environment.
> > > > > >
> > > > > > This is not an issue for upstream development as one usually updates
> > > > > > configs on the same system where the build takes place but it's a big
> > > > > > problem for distribution maintainers.
> > > >
> > > > If I recall correct the goal was to avoid trouble with clang, as it does not
> > > > support all processor types with -march. But yeah, in the original
> > > > consideration we only thought about upstream development and forgot the
> > > > distros.
> > > > > > > I did a quick search and couldn't find any other examples of Kconfigs
> > > > > > > depending on march or mtune compiler flags and it seems like it'd
> > > > > > > generally problematic for people preparing configurations.
> > > >
> > > > True, but not the whole story. Power and Arm64 use cc-option to check for
> > > > -mstack-protector*, which do not exist on s390. So you have the same problem
> > > > when you prepare a config for any of them on s390. Thus simply reverting the
> > > > commit you mentioned above does not solve the problem but merely hides one
> > > > symptom. Which also means that the original problem will return over and over
> > > > again in the future.
> > > >
> > > > An other reason why I don't think it makes sens to revert the commit is that it
> > > > would make cc-option as a whole useless. What's the benefit in having cc-option
> > > > when you are not allowed to use it? Or less provocative, in which use cases is
> > > > allowed to use cc-option?
> > >
> > >
> > > You are right.
> > > Reverting the particular s390 commit is not the solution.
> > >
> > >
> > > > > > There are more issues like this. In general, since 4.17 or 4.18, the
> > > > > > resulting config depends on both architecture and compiler version.
> > > > > > Earlier, you could simply run "ARCH=... make oldconfig" (or menuconfig)
> > > > > > to update configs for all architectures and distribution versions.
> > > > > > Today, you need to use the right compiler version (results with e.g.
> > > > > > 4.8, 7.4 and 9.2 differ) and architecture.
> > > > > >
> > > > >
> > > > > Yeah, that's also troublesome. This is by no means the first problem
> > > > > related to the environment at configuration time, but it the most
> > > > > bothersome to work around (at least for Fedora kernel configuration).
> > > > >
> > > > > > At the moment, I'm working around the issue by using chroot environments
> > > > > > with target distributions (e.g. openSUSE Tumbleweed) and set of cross
> > > > > > compilers for supported architectures but it's far from perfect and even
> > > > > > this way, there are problemantic points, e.g. BPFILTER_UMH which depends
> > > > > > on gcc being able to not only compile but also link.
> > > > > >
> > > > > > IMHO the key problem is that .config mixes configuration with
> > > > > > description of build environment. I have an idea of a solution which
> > > > > > would consist of
> > > > > >
> > > > > >   - an option to extract "config" options which describe build
> > > > > >     environment (i.e. their values are determined by running some
> > > > > >     command, rather than reading from a file or asking user) into
> > > > > >     a cache file
> > > > > >   - an option telling "make *config" to use such cache file for these
> > > > > >     environment "config" options instead of running the test scripts
> > > > > >     (and probably issue an error if an environment option is missing)
> > > > > >
> > > > >
> > > > > I agree that the issue is mixing kernel configuration with build
> > > > > environment. I suppose a cache file would work, but it still sounds like
> > > > > a difficult process that is working around that fact that folks are
> > > > > coupling the configuration step with the build step.
> > > >
> > > > An other solution would be a "I know better" switch which simply disables
> > > > cc-option for that run. That would allow the use of cc-option for upstream
> > > > development and provide a simple way for distros to turn it off.
> > > >
> > > > > I would advocate that this patch be reverted and an effort made to not
> > > > > mix build environment checks into the configuration. I'm much happier
> > > > > for the build to fail because the configuration can't be satisfied by
> > > > > the environment than I am for the configuration to quietly change or for
> > > > > the tools to not allow me to make the configuration in the first place.
> > > > > Ideally the tools would warn the user if their environment won't build
> > > > > the configuration, but that's a nice-to-have.
> > > >
> > > > I too would prefer to have a warning instead of the config being silently
> > > > changed. But again, the problem goes beyond what was reported.
> > > >
> > > > @Masahiro: What do you think about it?
> > > >
> > > > Thanks
> > > > Philipp
> > > >
> > >
> > >
> > > The problem for Jeremy and Michal is,
> > > it is difficult to get a full-feature cross-compiler
> > > for every arch.
> > >
> >
> > Indeed.
> >
> > > One idea to workaround this is
> > > to use a fake script that accepts any flag,
> > > and use it as $(CC) in Kconfig.
> > >
> > > RFC patch is attached.
> > >
> > > This is not a perfect solution, of course.
> > >
> >
> > The attached patch doesn't looks like it'd work for what we need,
> 
> I thought turning all cc-options to y would work
> for what you need.
> 
> With this, you can enable
> CONFIG_MARCH_Z13=y and CONFIG_TUNE_Z14=y
> instead of CONFIG_TUNE_DEFAULT.
> 
> If this approach does not work for you,
> what is your requirement?
> 

Oof, this was an awful typo. It *would* work for what we need. Sorry for
the confusion :(.

> 
> 
> > although I wonder if it's easier to just check when cc-options is
> > defined for an environment variable or something and always return y
> > instead of calling out to $(CC) at all. Comes to the same thing, I
> > suppose.
> 
> 
> The macro definition in scripts/Kconfig.include
> takes precedence over any environment variable.
> 
> So, if you want to hack it from the environment,
> you need to change the code somehow.
> 
> The scripts/dummy-tools/ approach does not change
> anything for the use-case in upstream.
> 
> The result is the same, of course.
> 

Indeed. Since I'm not maintaining it I don't have a particularly strong
opinion about the approach. Whatever you like most works for me.

- Jeremy
