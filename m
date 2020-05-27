Return-Path: <linux-kselftest-owner@vger.kernel.org>
Date: Wed, 27 May 2020 11:05:23 +0100 (BST)
From: Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH v3 3/7] kunit: tests for stats_fs API
In-Reply-To: <20200526110318.69006-4-eesposit@redhat.com>
Message-ID: <alpine.LRH.2.21.2005271054360.24819@localhost>
References: <20200526110318.69006-1-eesposit@redhat.com> <20200526110318.69006-4-eesposit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kselftest-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc: kvm@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, David Rientjes <rientjes@google.com>, Jonathan Adams <jwadams@google.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, brendanhiggins@google.com, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com

On Tue, 26 May 2020, Emanuele Giuseppe Esposito wrote:

> Add kunit tests to extensively test the stats_fs API functionality.
>

I've added in the kunit-related folks.
 
> In order to run them, the kernel .config must set CONFIG_KUNIT=y
> and a new .kunitconfig file must be created with CONFIG_STATS_FS=y
> and CONFIG_STATS_FS_TEST=y
>

It looks like CONFIG_STATS_FS is built-in, but it exports
much of the functionality you are testing.  However could the
tests also be built as a module (i.e. make CONFIG_STATS_FS_TEST
a tristate variable)? To test this you'd need to specify
CONFIG_KUNIT=m and CONFIG_STATS_FS_TEST=m, and testing would
simply be a case of "modprobe"ing the stats fs module and collecting
results in /sys/kernel/debug/kunit/<module_name> (rather 
than running kunit.py). Are you relying on unexported internals in
the the tests that would prevent building them as a module?

Thanks!

Alan
