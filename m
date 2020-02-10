Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26050 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727518AbgBJStq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Feb 2020 13:49:46 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01AIeJkC038803
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 13:49:45 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1tn52vsg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 13:49:45 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <prudo@linux.ibm.com>;
        Mon, 10 Feb 2020 18:49:43 -0000
Date: Mon, 10 Feb 2020 19:49:36 +0100
From: Philipp Rudo <prudo@linux.ibm.com>
Subject: Re: s390 depending on cc-options makes it difficult to configure
In-Reply-To: <20191211171822.GA36366@dev.jcline.org>
References: <20191209164155.GA78160@dev.jcline.org>
        <20191210090108.GA22512@unicorn.suse.cz>
        <20191211171822.GA36366@dev.jcline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20200210194936.511ef603@laptop2-ibm.local>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jeremy Cline <jcline@redhat.com>
Cc: Michal Kubecek <mkubecek@suse.cz>, linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>

Hey Jeremy,
Hey Michal,

sorry for the late response. The mail got lost in the pre-xmas rush...

In my opinion the problem goes beyond s390 and the commit you mentioned. So I'm
also adding Masahiro as Kconfig maintainer and author of cc-option.


On Wed, 11 Dec 2019 12:18:22 -0500
Jeremy Cline <jcline@redhat.com> wrote:

> On Tue, Dec 10, 2019 at 10:01:08AM +0100, Michal Kubecek wrote:
> > On Mon, Dec 09, 2019 at 11:41:55AM -0500, Jeremy Cline wrote:  
> > > Hi folks,
> > > 
> > > Commit 5474080a3a0a ("s390/Kconfig: make use of 'depends on cc-option'")
> > > makes it difficult to produce an s390 configuration for Fedora and Red
> > > Hat kernels.
> > > 
> > > The issue is I have the following configurations:
> > > 
> > > CONFIG_MARCH_Z13=y
> > > CONFIG_TUNE_Z14=y
> > > # CONFIG_TUNE_DEFAULT is not set
> > > 
> > > When the configuration is prepared on a non-s390x host without a
> > > compiler with -march=z* it changes CONFIG_TUNE_DEFAULT to y which, as
> > > far as I can tell, leads to a kernel tuned for z13 instead of z14.
> > > Fedora and Red Hat build processes produce complete configurations from
> > > snippets on any available host in the build infrastructure which very
> > > frequently is *not* s390.  
> > 
> > We have exactly the same problem. Our developers need to update config
> > files for different architectures and different kernel versions on their
> > machines which are usually x86_64 but that often produces different
> > configs than the real build environment.
> >   
> > This is not an issue for upstream development as one usually updates
> > configs on the same system where the build takes place but it's a big
> > problem for distribution maintainers.

If I recall correct the goal was to avoid trouble with clang, as it does not
support all processor types with -march. But yeah, in the original
consideration we only thought about upstream development and forgot the
distros.

> > > I did a quick search and couldn't find any other examples of Kconfigs
> > > depending on march or mtune compiler flags and it seems like it'd
> > > generally problematic for people preparing configurations.  

True, but not the whole story. Power and Arm64 use cc-option to check for
-mstack-protector*, which do not exist on s390. So you have the same problem 
when you prepare a config for any of them on s390. Thus simply reverting the
commit you mentioned above does not solve the problem but merely hides one
symptom. Which also means that the original problem will return over and over
again in the future.

An other reason why I don't think it makes sens to revert the commit is that it
would make cc-option as a whole useless. What's the benefit in having cc-option
when you are not allowed to use it? Or less provocative, in which use cases is
allowed to use cc-option?

> > There are more issues like this. In general, since 4.17 or 4.18, the
> > resulting config depends on both architecture and compiler version.
> > Earlier, you could simply run "ARCH=... make oldconfig" (or menuconfig)
> > to update configs for all architectures and distribution versions.
> > Today, you need to use the right compiler version (results with e.g.
> > 4.8, 7.4 and 9.2 differ) and architecture.
> >   
> 
> Yeah, that's also troublesome. This is by no means the first problem
> related to the environment at configuration time, but it the most
> bothersome to work around (at least for Fedora kernel configuration).
> 
> > At the moment, I'm working around the issue by using chroot environments
> > with target distributions (e.g. openSUSE Tumbleweed) and set of cross
> > compilers for supported architectures but it's far from perfect and even
> > this way, there are problemantic points, e.g. BPFILTER_UMH which depends
> > on gcc being able to not only compile but also link.
> > 
> > IMHO the key problem is that .config mixes configuration with
> > description of build environment. I have an idea of a solution which
> > would consist of
> > 
> >   - an option to extract "config" options which describe build
> >     environment (i.e. their values are determined by running some
> >     command, rather than reading from a file or asking user) into
> >     a cache file
> >   - an option telling "make *config" to use such cache file for these
> >     environment "config" options instead of running the test scripts
> >     (and probably issue an error if an environment option is missing)
> >   
> 
> I agree that the issue is mixing kernel configuration with build
> environment. I suppose a cache file would work, but it still sounds like
> a difficult process that is working around that fact that folks are
> coupling the configuration step with the build step.

An other solution would be a "I know better" switch which simply disables
cc-option for that run. That would allow the use of cc-option for upstream
development and provide a simple way for distros to turn it off.

> I would advocate that this patch be reverted and an effort made to not
> mix build environment checks into the configuration. I'm much happier
> for the build to fail because the configuration can't be satisfied by
> the environment than I am for the configuration to quietly change or for
> the tools to not allow me to make the configuration in the first place.
> Ideally the tools would warn the user if their environment won't build
> the configuration, but that's a nice-to-have.

I too would prefer to have a warning instead of the config being silently
changed. But again, the problem goes beyond what was reported.

@Masahiro: What do you think about it?

Thanks
Philipp  
