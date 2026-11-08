Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794143784;
	b=1p1+6mjkoXeVzcV43/M7gLE413QT918nUgn62Op1Uck+B91g9OEv8fu58mDno+8WQvcS
	 aaEadsHIrcn3dBRhu/aKebcI/LX99uMzjuYAd6ppfbTua9ICeGhRZy5uAMu71h1l8dAg0
	 cmoLQtf30XB1uoNHwjypsuwMVOofcu24Efb2sYJW9ZEDr3luhEZVp8WYteEhyjRW2SAVu
	 /1iXGcaH1FCwHCx1pBNTRWEBYzAVQxpfJfwbWZOThISZkx5oUptG8GKjptA14xi4vgIWP
	 fXpgvSoNZgLZSZHo++jrneIa5sePgNXdNNrT47JRv/X/tfA6b+YWdHzQrkZSBHFSD6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794143784;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XVUOW6BOzWiFpos3QddCcYSf9omcPbHzIw8nadBPHoM=;
	b=46TBJD9O2YVRObRTlSSjc2hAllvoI1hHXvYgxAcNTU/MIB0dGjNKdQ4Rk66kpFFAN5to
	 yEBISveuV6zqwF+IWGAegVnqjL6hglGtGDJKqBPVBkSKHRcUJD1lvKA/BWbB0TZZtRmPw
	 Aj+9z3HvOmqaotRkemc6NgSEojfpQEFiO1UNLdNoUrLsiEyNJXeJdP0P4lSGjV8Qf4nu/
	 tHHxa37TjIUeV0ct1jh8FwGu3MBJUXPtKC9aq9uMnZ+i2XEvaxoXCbGDyiRlZCvh87rNq
	 4RSbL1dWDAx9Pfu8+eF/84ugAz62RcLX3xbmHgPtcZdzyM0ibxjVZwmNSBWTRiHbfOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gnxjxc8y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836A4606A321;
	Sun,  8 Nov 2026 13:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gnxjxc8y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03981F0089F;
	Sun,  8 Nov 2026 13:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794143784;
	bh=XVUOW6BOzWiFpos3QddCcYSf9omcPbHzIw8nadBPHoM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gnxjxc8yt6ns+DUYYHwQ/38iNk2Vq6zbFeb4zKpN57mNXmBsz/JBPRpkrmjHES0+n
	 nUQLkU8IZl50Bxfx6hq7tmdQ7wkwiEy05XZz3pHzbzi+rLchoptyr054Wq5YZWMXao
	 IBes2mccwDOAFeesInJk0oNrWza7TWzsXzZ5UnSZgeLIozRHdeBkeB+ArgdTcC0rKk
	 dLfbyVE6tgs682BBtFh7TePDls5/2rgkhaEvSCw9dKGOm+4AaZ4Yd8spypnTGQQ+om
	 4iY+dOMs3D73AOh1+1Nimn1jGEoPCotCquvGr6uQ9r7rFIzNKoYRbHRDv2dv1nHw2/
	 k6rbeoJlvspbA==
Message-ID: <sashiko-outbox-203767@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/11] rxrpc: Move key types to their own module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "David Howells" <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Anna Schumaker" <anna@kernel.org>, "Bharath
 SM" <bharathsm@microsoft.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "David
 S. Miller" <davem@davemloft.net>, "Eric Biggers" <ebiggers@kernel.org>, "Eric
 Dumazet" <edumazet@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "James Bottomley" <James.Bottomley@HansenPartnership.com>, "James
 Morris" <jmorris@namei.org>, "Marc Dionne" <marc.dionne@auristor.com>, "Mimi
 Zohar" <zohar@linux.ibm.com>, "Namjae Jeon" <linkinjeon@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "Paulo
 Alcantara" <pc@manguebit.org>, "Ronnie Sahlberg" <ronniesahlberg@gmail.com>, "Serge
 E. Hallyn" <serge@hallyn.com>, "Shyam Prasad N" <sprasad@microsoft.com>, "Simon
 Horman" <horms@kernel.org>, "Sumit Garg" <sumit.garg@kernel.org>, "Sven
 Schnelle" <svens@linux.ibm.com>, "Tom Talpey" <tom@talpey.com>, "Trond
 Myklebust" <trondmy@kernel.org>, "Vasily Gorbik" <gor@linux.ibm.com>, "Chuck
 Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>
In-Reply-To: <20261107131512.3603168-9-jarkko@kernel.org>
References: <20261107131512.3603168-1-jarkko@kernel.org>
 <20261107131512.3603168-9-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 13:16:22 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] rxrpc: update kernel-doc path from server_key.c to security.c in
  rxrpc.rst
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [High] rxrpc: memory leak of conn->key in rxrpc_process_event() [1]
--

commit 16a0f09dc6df360865624dc81f7bfb1b9505bec6
Author: Jarkko Sakkinen <jarkko@kernel.org>

rxrpc: Move key types to their own module

This commit splits the rxrpc and rxrpc_s key types and their preparse
logic into a separate rxrpc_keys.ko module and moves socket and
connection key helper functions into net/rxrpc/security.c so rxrpc.ko
can be unloaded while persistent keys remain in keyrings.

> diff --git a/net/rxrpc/security.c b/net/rxrpc/security.c
> index 2bfbf2b2bb37a..28883a70c9e85 100644
> --- a/net/rxrpc/security.c
> +++ b/net/rxrpc/security.c

[ ... ]

> +/*
> + * generate a server data key
> + */
> +int rxrpc_get_server_data_key(struct rxrpc_connection *conn,
> +			      const void *session_key,
> +			      time64_t expiry,
> +			      u32 kvno)
> +{
> +	const struct cred *cred =3D current_cred();
> +	struct {
> +		u32 kver;
> +		struct rxrpc_key_data_v1 v1;
> +	} data;
> +	struct key *key;
> +	int ret;
> +
> +	_enter("");
> +
> +	key =3D key_alloc(&key_type_rxrpc, "x",
> +			GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, cred, 0,
> +			KEY_ALLOC_NOT_IN_QUOTA, NULL);
> +	if (IS_ERR(key)) {
> +		_leave(" =3D -ENOMEM [alloc %ld]", PTR_ERR(key));
> +		return -ENOMEM;
> +	}
> +
> +	_debug("key %d", key_serial(key));
> +
> +	data.kver =3D 1;
> +	data.v1.security_index =3D RXRPC_SECURITY_RXKAD;
> +	data.v1.ticket_length =3D 0;
> +	data.v1.expiry =3D rxrpc_time64_to_u32(expiry);
> +	data.v1.kvno =3D 0;
> +
> +	memcpy(&data.v1.session_key, session_key, sizeof(data.v1.session_key));
> +
> +	ret =3D key_instantiate_and_link(key, &data, sizeof(data), NULL, NULL);
> +	if (ret < 0)
> +		goto error;
> +
> +	conn->key =3D key;

[Severity: High]
This problem wasn't introduced by this patch, but can assigning conn->key
here leak an existing key [1] if a RESPONSE packet is replayed?

In rxrpc_process_event(), if rxrpc_verify_response() succeeds (allocating
and assigning conn->key via rxrpc_get_server_data_key()) but the subsequent
conn->security->init_connection_security() call fails, the function returns
early while conn->state remains RXRPC_CONN_SERVICE_CHALLENGING:

net/rxrpc/conn_event.c:rxrpc_process_event() {
    ...
	case RXRPC_PACKET_TYPE_RESPONSE:
		spin_lock_irq(&conn->state_lock);
		if (conn->state !=3D RXRPC_CONN_SERVICE_CHALLENGING) {
			spin_unlock_irq(&conn->state_lock);
			return 0;
		}
		spin_unlock_irq(&conn->state_lock);

		ret =3D rxrpc_verify_response(conn, skb);
		if (ret < 0)
			return ret;

		ret =3D conn->security->init_connection_security(
			conn, conn->key->payload.data[0]);
		if (ret < 0)
			return ret;
    ...
}

A replayed RESPONSE packet will then run rxrpc_verify_response() again and
overwrite conn->key without calling key_put() on the previous key.

[ ... ]

> +/**
> + * rxrpc_sock_set_security_keyring - Set the security keyring for a kern=
el service
> + * @sk: The socket to set the keyring on
> + * @keyring: The keyring to set
> + *
> + * Set the server security keyring on an rxrpc socket.  This is used to =
provide
> + * the encryption keys for a kernel service.
> + *
> + * Return: %0 if successful and a negative error code otherwise.
> + */
> +int rxrpc_sock_set_security_keyring(struct sock *sk, struct key *keyring)
> +{

[ ... ]

> +/**
> + * rxrpc_sock_set_manage_response - Set the manage-response flag for a k=
ernel service

[Severity: Low]
Moving rxrpc_sock_set_security_keyring() and rxrpc_sock_set_manage_response=
()
from net/rxrpc/server_key.c to net/rxrpc/security.c leaves no kernel-doc
comments in net/rxrpc/server_key.c, while Documentation/networking/rxrpc.rst
still has:

  .. kernel-doc:: net/rxrpc/server_key.c
     :internal:

Should that directive in Documentation/networking/rxrpc.rst be updated to
reference net/rxrpc/security.c so these functions remain in the generated A=
PI
documentation?

[1] https://sashiko.dev/#/bug/linux-93795e42-6eae-42ec-9f00-b78f9b947f35

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107131512.3603=
168-1-jarkko@kernel.org?part=3D8
