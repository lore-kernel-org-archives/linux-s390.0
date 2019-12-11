Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26193 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729996AbfLKRS3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 11 Dec 2019 12:18:29 -0500
Received: by mail-yb1-f199.google.com with SMTP id n80so16978037ybf.18
        for <linux-s390@vger.kernel.org>; Wed, 11 Dec 2019 09:18:26 -0800 (PST)
Date: Wed, 11 Dec 2019 12:18:22 -0500
From: Jeremy Cline <jcline@redhat.com>
Subject: Re: s390 depending on cc-options makes it difficult to configure
Message-ID: <20191211171822.GA36366@dev.jcline.org>
References: <20191209164155.GA78160@dev.jcline.org>
 <20191210090108.GA22512@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210090108.GA22512@unicorn.suse.cz>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org

On Tue, Dec 10, 2019 at 10:01:08AM +0100, Michal Kubecek wrote:
> On Mon, Dec 09, 2019 at 11:41:55AM -0500, Jeremy Cline wrote:
> > Hi folks,
> > 
> > Commit 5474080a3a0a ("s390/Kconfig: make use of 'depends on cc-option'")
> > makes it difficult to produce an s390 configuration for Fedora and Red
> > Hat kernels.
> > 
> > The issue is I have the following configurations:
> > 
> > CONFIG_MARCH_Z13=y
> > CONFIG_TUNE_Z14=y
> > # CONFIG_TUNE_DEFAULT is not set
> > 
> > When the configuration is prepared on a non-s390x host without a
> > compiler with -march=z* it changes CONFIG_TUNE_DEFAULT to y which, as
> > far as I can tell, leads to a kernel tuned for z13 instead of z14.
> > Fedora and Red Hat build processes produce complete configurations from
> > snippets on any available host in the build infrastructure which very
> > frequently is *not* s390.
> 
> We have exactly the same problem. Our developers need to update config
> files for different architectures and different kernel versions on their
> machines which are usually x86_64 but that often produces different
> configs than the real build environment.
> 

Glad (or sad?) to hear we're not the only ones hitting this.

> This is not an issue for upstream development as one usually updates
> configs on the same system where the build takes place but it's a big
> problem for distribution maintainers.
> 
> > I did a quick search and couldn't find any other examples of Kconfigs
> > depending on march or mtune compiler flags and it seems like it'd
> > generally problematic for people preparing configurations.
> 
> There are more issues like this. In general, since 4.17 or 4.18, the
> resulting config depends on both architecture and compiler version.
> Earlier, you could simply run "ARCH=... make oldconfig" (or menuconfig)
> to update configs for all architectures and distribution versions.
> Today, you need to use the right compiler version (results with e.g.
> 4.8, 7.4 and 9.2 differ) and architecture.
> 

Yeah, that's also troublesome. This is by no means the first problem
related to the environment at configuration time, but it the most
bothersome to work around (at least for Fedora kernel configuration).

> At the moment, I'm working around the issue by using chroot environments
> with target distributions (e.g. openSUSE Tumbleweed) and set of cross
> compilers for supported architectures but it's far from perfect and even
> this way, there are problemantic points, e.g. BPFILTER_UMH which depends
> on gcc being able to not only compile but also link.
> 
> IMHO the key problem is that .config mixes configuration with
> description of build environment. I have an idea of a solution which
> would consist of
> 
>   - an option to extract "config" options which describe build
>     environment (i.e. their values are determined by running some
>     command, rather than reading from a file or asking user) into
>     a cache file
>   - an option telling "make *config" to use such cache file for these
>     environment "config" options instead of running the test scripts
>     (and probably issue an error if an environment option is missing)
> 

I agree that the issue is mixing kernel configuration with build
environment. I suppose a cache file would work, but it still sounds like
a difficult process that is working around that fact that folks are
coupling the configuration step with the build step.

I would advocate that this patch be reverted and an effort made to not
mix build environment checks into the configuration. I'm much happier
for the build to fail because the configuration can't be satisfied by
the environment than I am for the configuration to quietly change or for
the tools to not allow me to make the configuration in the first place.
Ideally the tools would warn the user if their environment won't build
the configuration, but that's a nice-to-have.

- Jeremy
