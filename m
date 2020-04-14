Return-Path: <netdev-owner@vger.kernel.org>
Date: Tue, 14 Apr 2020 21:16:01 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Subject: Re: [PATCH v2 2/2] crypto: Remove unnecessary memzero_explicit()
Message-ID: <20200414191601.GZ25468@kitsune.suse.cz>
References: <20200413211550.8307-1-longman@redhat.com>
 <20200413222846.24240-1-longman@redhat.com>
 <eca85e0b-0af3-c43a-31e4-bd5c3f519798@c-s.fr>
 <e194a51f-a5e5-a557-c008-b08cac558572@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e194a51f-a5e5-a557-c008-b08cac558572@redhat.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Linus Torvalds <torvalds@linux-foundation.org>, Joe Perches <joe@perches.com>, Matthew Wilcox <willy@infradead.org>, David Rientjes <rientjes@google.com>, linux-mm@kvack.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-crypto@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-mediatek@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, linux-ppp@vger.kernel.org, wireguard@lists.zx2c4.com, linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, linux-fscrypt@vger.kernel.org, ecryptfs@vger.kernel.org, kasan-dev@googlegroups.com, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, linux-sctp@vger.kernel.org, linux-nfs@vger.kernel.org, tipc-discussion@lists.sourceforge.net, cocci@systeme.lip6.fr, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org

On Tue, Apr 14, 2020 at 12:24:36PM -0400, Waiman Long wrote:
> On 4/14/20 2:08 AM, Christophe Leroy wrote:
> >
> >
> > Le 14/04/2020 =EF=BF=BD 00:28, Waiman Long a =EF=BF=BDcrit=EF=BF=BD:
> >> Since kfree_sensitive() will do an implicit memzero_explicit(), there
> >> is no need to call memzero_explicit() before it. Eliminate those
> >> memzero_explicit() and simplify the call sites. For better correctness,
> >> the setting of keylen is also moved down after the key pointer check.
> >>
> >> Signed-off-by: Waiman Long <longman@redhat.com>
> >> ---
> >> =EF=BF=BD .../allwinner/sun8i-ce/sun8i-ce-cipher.c=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD | 19 +++++-------------
> >> =EF=BF=BD .../allwinner/sun8i-ss/sun8i-ss-cipher.c=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD | 20 +++++--------------
> >> =EF=BF=BD drivers/crypto/amlogic/amlogic-gxl-cipher.c=EF=BF=BD=EF=BF=
=BD | 12 +++--------
> >> =EF=BF=BD drivers/crypto/inside-secure/safexcel_hash.c=EF=BF=BD |=EF=
=BF=BD 3 +--
> >> =EF=BF=BD 4 files changed, 14 insertions(+), 40 deletions(-)
> >>
> >> diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
> >> b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
> >> index aa4e8fdc2b32..8358fac98719 100644
> >> --- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
> >> +++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
> >> @@ -366,10 +366,7 @@ void sun8i_ce_cipher_exit(struct crypto_tfm *tfm)
> >> =EF=BF=BD {
> >> =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD struct sun8i_cipher_tfm_=
ctx *op =3D crypto_tfm_ctx(tfm);
> >> =EF=BF=BD -=EF=BF=BD=EF=BF=BD=EF=BF=BD if (op->key) {
> >> -=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD memze=
ro_explicit(op->key, op->keylen);
> >> -=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD kfree=
(op->key);
> >> -=EF=BF=BD=EF=BF=BD=EF=BF=BD }
> >> +=EF=BF=BD=EF=BF=BD=EF=BF=BD kfree_sensitive(op->key);
> >> =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD crypto_free_sync_skciphe=
r(op->fallback_tfm);
> >> =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD pm_runtime_put_sync_susp=
end(op->ce->dev);
> >> =EF=BF=BD }
> >> @@ -391,14 +388,11 @@ int sun8i_ce_aes_setkey(struct crypto_skcipher
> >> *tfm, const u8 *key,
> >> =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD dev_dbg(ce->dev, "ERROR: Invalid keylen %u\n", keylen);
> >> =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD return -EINVAL;
> >> =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD }
> >> -=EF=BF=BD=EF=BF=BD=EF=BF=BD if (op->key) {
> >> -=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD memze=
ro_explicit(op->key, op->keylen);
> >> -=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD kfree=
(op->key);
> >> -=EF=BF=BD=EF=BF=BD=EF=BF=BD }
> >> -=EF=BF=BD=EF=BF=BD=EF=BF=BD op->keylen =3D keylen;
> >> +=EF=BF=BD=EF=BF=BD=EF=BF=BD kfree_sensitive(op->key);
> >> =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD op->key =3D kmemdup(key,=
 keylen, GFP_KERNEL | GFP_DMA);
> >> =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD if (!op->key)
> >> =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD return -ENOMEM;
> >> +=EF=BF=BD=EF=BF=BD=EF=BF=BD op->keylen =3D keylen;
> >
> > Does it matter at all to ensure op->keylen is not set when of->key is
> > NULL ? I'm not sure.
> >
> > But if it does, then op->keylen should be set to 0 when freeing op->key=
.=20
>=20
> My thinking is that if memory allocation fails, we just don't touch
> anything and return an error code. I will not explicitly set keylen to 0
> in this case unless it is specified in the API documentation.
You already freed the key by now so not touching anything is not
possible. The key is set to NULL on allocation failure so setting keylen
to 0 should be redundant. However, setting keylen to 0 is consisent with
not having a key, and it avoids the possibility of leaking the length
later should that ever cause any problem.

Thanks

Michal
