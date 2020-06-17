Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v4 0/3] mm, treewide: Rename kzfree() to kfree_sensitive()
From: Jo -l <joel.voyer@gmail.com>
In-Reply-To: <20200617003711.GD8681@bombadil.infradead.org>
Date: Wed, 17 Jun 2020 10:03:30 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <29829792-2C3E-44D1-A337-E206F1B6C92A@gmail.com>
References: <20200616015718.7812-1-longman@redhat.com>
 <fe3b9a437be4aeab3bac68f04193cb6daaa5bee4.camel@perches.com>
 <20200616230130.GJ27795@twin.jikos.cz>
 <20200617003711.GD8681@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: dsterba@suse.cz, Joe Perches <joe@perches.com>, Waiman Long <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Linus Torvalds <torvalds@linux-foundation.org>, David Rientjes <rientjes@google.com>, Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, Dan Carpenter <dan.carpenter@oracle.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-mm@kvack.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, linux-pm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-amlogic@lists.infradead.org, linux-mediatek@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-ppp@vger.kernel.org, wireguard@lists.zx2c4.com, linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-fscrypt@vger.kernel.org, ecryptfs@vger.kernel.org, kasan-dev@googlegroups.com, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, linux-sctp@vger.kernel.org, linux-nfs@vger.kernel.org, tipc-discussion@lists.sourceforge.net, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org

Bonjour,
D=C3=A9sol=C3=A9, aucune traduction possible,=20
En fran=C3=A7ais pour comprendre!
Merci
slts

> Le 17 06 2020 =C3=A0 02:37, Matthew Wilcox <willy@infradead.org> a =
=C3=A9crit :
>=20
> On Wed, Jun 17, 2020 at 01:01:30AM +0200, David Sterba wrote:
>> On Tue, Jun 16, 2020 at 11:53:50AM -0700, Joe Perches wrote:
>>> On Mon, 2020-06-15 at 21:57 -0400, Waiman Long wrote:
>>>> v4:
>>>> - Break out the memzero_explicit() change as suggested by Dan =
Carpenter
>>>>  so that it can be backported to stable.
>>>> - Drop the "crypto: Remove unnecessary memzero_explicit()" patch =
for
>>>>  now as there can be a bit more discussion on what is best. It will =
be
>>>>  introduced as a separate patch later on after this one is merged.
>>>=20
>>> To this larger audience and last week without reply:
>>> =
https://lore.kernel.org/lkml/573b3fbd5927c643920e1364230c296b23e7584d.came=
l@perches.com/
>>>=20
>>> Are there _any_ fastpath uses of kfree or vfree?
>>=20
>> I'd consider kfree performance critical for cases where it is called
>> under locks. If possible the kfree is moved outside of the critical
>> section, but we have rbtrees or lists that get deleted under locks =
and
>> restructuring the code to do eg. splice and free it outside of the =
lock
>> is not always possible.
>=20
> Not just performance critical, but correctness critical.  Since =
kvfree()
> may allocate from the vmalloc allocator, I really think that kvfree()
> should assert that it's !in_atomic().  Otherwise we can get into =
trouble
> if we end up calling vfree() and have to take the mutex.

Jo-l
joel.voyer@gmail.com
