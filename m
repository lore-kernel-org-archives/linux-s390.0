Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42277 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2391470AbgDNQZF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Apr 2020 12:25:05 -0400
Subject: Re: [PATCH v2 2/2] crypto: Remove unnecessary memzero_explicit()
References: <20200413211550.8307-1-longman@redhat.com>
 <20200413222846.24240-1-longman@redhat.com>
 <eca85e0b-0af3-c43a-31e4-bd5c3f519798@c-s.fr>
From: Waiman Long <longman@redhat.com>
Message-ID: <e194a51f-a5e5-a557-c008-b08cac558572@redhat.com>
Date: Tue, 14 Apr 2020 12:24:36 -0400
MIME-Version: 1.0
In-Reply-To: <eca85e0b-0af3-c43a-31e4-bd5c3f519798@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Linus Torvalds <torvalds@linux-foundation.org>, Joe Perches <joe@perches.com>, Matthew Wilcox <willy@infradead.org>, David Rientjes <rientjes@google.com>
Cc: linux-mm@kvack.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-crypto@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-mediatek@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, linux-ppp@vger.kernel.org, wireguard@lists.zx2c4.com, linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, linux-fscrypt@vger.kernel.org, ecryptfs@vger.kernel.org, kasan-dev@googlegroups.com, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, linux-sctp@vger.kernel.org, linux-nfs@vger.kernel.org, tipc-discussion@lists.sourceforge.net, cocci@systeme.lip6.fr, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org

On 4/14/20 2:08 AM, Christophe Leroy wrote:
>
>
> Le 14/04/2020 =C3=A0 00:28, Waiman Long a =C3=A9crit=C2=A0:
>> Since kfree_sensitive() will do an implicit memzero_explicit(), there
>> is no need to call memzero_explicit() before it. Eliminate those
>> memzero_explicit() and simplify the call sites. For better correctness=
,
>> the setting of keylen is also moved down after the key pointer check.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>> =C2=A0 .../allwinner/sun8i-ce/sun8i-ce-cipher.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 19 +++++-------------
>> =C2=A0 .../allwinner/sun8i-ss/sun8i-ss-cipher.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 20 +++++--------------
>> =C2=A0 drivers/crypto/amlogic/amlogic-gxl-cipher.c=C2=A0=C2=A0 | 12 ++=
+--------
>> =C2=A0 drivers/crypto/inside-secure/safexcel_hash.c=C2=A0 |=C2=A0 3 +-=
-
>> =C2=A0 4 files changed, 14 insertions(+), 40 deletions(-)
>>
>> diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
>> b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
>> index aa4e8fdc2b32..8358fac98719 100644
>> --- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
>> +++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
>> @@ -366,10 +366,7 @@ void sun8i_ce_cipher_exit(struct crypto_tfm *tfm)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sun8i_cipher_tfm_ctx *op =3D cry=
pto_tfm_ctx(tfm);
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (op->key) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memzero_explicit(op->key, =
op->keylen);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(op->key);
>> -=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 kfree_sensitive(op->key);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 crypto_free_sync_skcipher(op->fallback_=
tfm);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_put_sync_suspend(op->ce->dev=
);
>> =C2=A0 }
>> @@ -391,14 +388,11 @@ int sun8i_ce_aes_setkey(struct crypto_skcipher
>> *tfm, const u8 *key,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(ce->dev=
, "ERROR: Invalid keylen %u\n", keylen);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 if (op->key) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memzero_explicit(op->key, =
op->keylen);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(op->key);
>> -=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 op->keylen =3D keylen;
>> +=C2=A0=C2=A0=C2=A0 kfree_sensitive(op->key);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op->key =3D kmemdup(key, keylen, GFP_KE=
RNEL | GFP_DMA);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!op->key)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>> +=C2=A0=C2=A0=C2=A0 op->keylen =3D keylen;
>
> Does it matter at all to ensure op->keylen is not set when of->key is
> NULL ? I'm not sure.
>
> But if it does, then op->keylen should be set to 0 when freeing op->key=
.=20

My thinking is that if memory allocation fails, we just don't touch
anything and return an error code. I will not explicitly set keylen to 0
in this case unless it is specified in the API documentation.

Cheers,
Longman
