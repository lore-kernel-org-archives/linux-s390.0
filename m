Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 10 Dec 2019 10:01:08 +0100
From: Michal Kubecek <mkubecek@suse.cz>
Subject: Re: s390 depending on cc-options makes it difficult to configure
Message-ID: <20191210090108.GA22512@unicorn.suse.cz>
References: <20191209164155.GA78160@dev.jcline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209164155.GA78160@dev.jcline.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Jeremy Cline <jcline@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org

On Mon, Dec 09, 2019 at 11:41:55AM -0500, Jeremy Cline wrote:
> Hi folks,
> 
> Commit 5474080a3a0a ("s390/Kconfig: make use of 'depends on cc-option'")
> makes it difficult to produce an s390 configuration for Fedora and Red
> Hat kernels.
> 
> The issue is I have the following configurations:
> 
> CONFIG_MARCH_Z13=y
> CONFIG_TUNE_Z14=y
> # CONFIG_TUNE_DEFAULT is not set
> 
> When the configuration is prepared on a non-s390x host without a
> compiler with -march=z* it changes CONFIG_TUNE_DEFAULT to y which, as
> far as I can tell, leads to a kernel tuned for z13 instead of z14.
> Fedora and Red Hat build processes produce complete configurations from
> snippets on any available host in the build infrastructure which very
> frequently is *not* s390.

We have exactly the same problem. Our developers need to update config
files for different architectures and different kernel versions on their
machines which are usually x86_64 but that often produces different
configs than the real build environment.

This is not an issue for upstream development as one usually updates
configs on the same system where the build takes place but it's a big
problem for distribution maintainers.

> I did a quick search and couldn't find any other examples of Kconfigs
> depending on march or mtune compiler flags and it seems like it'd
> generally problematic for people preparing configurations.

There are more issues like this. In general, since 4.17 or 4.18, the
resulting config depends on both architecture and compiler version.
Earlier, you could simply run "ARCH=... make oldconfig" (or menuconfig)
to update configs for all architectures and distribution versions.
Today, you need to use the right compiler version (results with e.g.
4.8, 7.4 and 9.2 differ) and architecture.

At the moment, I'm working around the issue by using chroot environments
with target distributions (e.g. openSUSE Tumbleweed) and set of cross
compilers for supported architectures but it's far from perfect and even
this way, there are problemantic points, e.g. BPFILTER_UMH which depends
on gcc being able to not only compile but also link.

IMHO the key problem is that .config mixes configuration with
description of build environment. I have an idea of a solution which
would consist of

  - an option to extract "config" options which describe build
    environment (i.e. their values are determined by running some
    command, rather than reading from a file or asking user) into
    a cache file
  - an option telling "make *config" to use such cache file for these
    environment "config" options instead of running the test scripts
    (and probably issue an error if an environment option is missing)

This would be perhaps even easier if we also separated the environment
descripton into a different file so that we would only need an option
telling scripts/kconfig/conf not to update the environment description.
I'm not sure if that would be acceptable for upstream, though.

Unfortunately I didn't find time to implement this yet.

Michal Kubecek
