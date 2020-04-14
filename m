Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.zx2c4.com ([192.95.5.64]:52379 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436826AbgDNIcL (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 14 Apr 2020 04:32:11 -0400
Subject: Re: [PATCH 1/2] mm, treewide: Rename kzfree() to kfree_sensitive()
References: <20200413211550.8307-1-longman@redhat.com>
 <20200413211550.8307-2-longman@redhat.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Message-ID: <4babf834-c531-50ba-53f6-e88410b15ce3@zx2c4.com>
Date: Tue, 14 Apr 2020 02:32:03 -0600
MIME-Version: 1.0
In-Reply-To: <20200413211550.8307-2-longman@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Waiman Long <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Linus Torvalds <torvalds@linux-foundation.org>, Joe Perches <joe@perches.com>, Matthew Wilcox <willy@infradead.org>, David Rientjes <rientjes@google.com>
Cc: linux-mm@kvack.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-crypto@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-mediatek@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, linux-ppp@vger.kernel.org, wireguard@lists.zx2c4.com, linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, linux-fscrypt@vger.kernel.org, ecryptfs@vger.kernel.org, kasan-dev@googlegroups.com, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, linux-sctp@vger.kernel.org, linux-nfs@vger.kernel.org, tipc-discussion@lists.sourceforge.net, cocci@systeme.lip6.fr, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org

On 4/13/20 3:15 PM, Waiman Long wrote:
> As said by Linus:
> 
>    A symmetric naming is only helpful if it implies symmetries in use.
>    Otherwise it's actively misleading.
> 
>    In "kzalloc()", the z is meaningful and an important part of what the
>    caller wants.
> 
>    In "kzfree()", the z is actively detrimental, because maybe in the
>    future we really _might_ want to use that "memfill(0xdeadbeef)" or
>    something. The "zero" part of the interface isn't even _relevant_.
> 
> The main reason that kzfree() exists is to clear sensitive information
> that should not be leaked to other future users of the same memory
> objects.
> 
> Rename kzfree() to kfree_sensitive() to follow the example of the
> recently added kvfree_sensitive() and make the intention of the API
> more explicit. 

Seems reasonable to me. One bikeshed, that you can safely discard and 
ignore as a mere bikeshed: kfree_memzero or kfree_scrub or 
kfree_{someverb} seems like a better function name, as it describes what 
the function does, rather than "_sensitive" that suggests something 
about the data maybe but who knows what that entails. If you disagree, 
not a big deal either way.

 > In addition, memzero_explicit() is used to clear the
 > memory to make sure that it won't get optimized away by the compiler.

This had occurred to me momentarily a number of years ago, but I was 
under the impression that the kernel presumes extern function calls to 
always imply a compiler barrier, making it difficult for the compiler to 
reason about what happens in/after kfree, in order to be able to 
optimize out the preceding memset. With LTO, that rule obviously 
changes. I guess new code should be written with cross-object 
optimizations in mind now a days? [Meanwhile, it would be sort of 
interesting to teach gcc about kfree to enable additional scary 
optimizations...]
