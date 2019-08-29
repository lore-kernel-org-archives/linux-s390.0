Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53654 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727017AbfH2L4d (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 29 Aug 2019 07:56:33 -0400
Subject: Re: [PATCH] KVM: s390: Test for bad access register at the start of
 S390_MEM_OP
References: <20190829105356.27805-1-thuth@redhat.com>
 <870234c7-47ed-6a96-0edf-66d9c2cd7ac0@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4b0ebaab-e287-9a2a-1696-5759f17cafef@redhat.com>
Date: Thu, 29 Aug 2019 13:56:15 +0200
MIME-Version: 1.0
In-Reply-To: <870234c7-47ed-6a96-0edf-66d9c2cd7ac0@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Trx6kqpy5WJ0k5aw1kWN52k1y2o1CINuq"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Trx6kqpy5WJ0k5aw1kWN52k1y2o1CINuq
Content-Type: multipart/mixed; boundary="QKFIlaPPmFxfhOjxUnC9rG6sazMpabRY6";
 protected-headers="v1"
From: Thomas Huth <thuth@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <4b0ebaab-e287-9a2a-1696-5759f17cafef@redhat.com>
Subject: Re: [PATCH] KVM: s390: Test for bad access register at the start of
 S390_MEM_OP
References: <20190829105356.27805-1-thuth@redhat.com>
 <870234c7-47ed-6a96-0edf-66d9c2cd7ac0@linux.ibm.com>
In-Reply-To: <870234c7-47ed-6a96-0edf-66d9c2cd7ac0@linux.ibm.com>

--QKFIlaPPmFxfhOjxUnC9rG6sazMpabRY6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29/08/2019 13.15, Janosch Frank wrote:
[...]
> By the way, I think we want to check mop->size for 0 before giving it t=
o
> vmalloc and working with it.

You're right! This currently triggers a kernel warning message with a
Call Trace! I'll add a check to my new memop selftest and send a patch...=


 Thomas


--QKFIlaPPmFxfhOjxUnC9rG6sazMpabRY6--

--Trx6kqpy5WJ0k5aw1kWN52k1y2o1CINuq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJ7iIR+7gJQEY8+q5LtnXdP5wLbUFAl1nvV8ACgkQLtnXdP5w
LbUOSg/9HVqCYFJXy4Qnu370GW8nAlLmLQeoYNC/MNrIVyG98zDa5IercTJLsmzC
qoLqi7rzgjIqaAdyfd/xKKeCfOceURDZw8Xcbz4Zjw62zsMRPzO4DQYhpR7Mh1o9
XqXMQxjBIJrVPdAKmFOg48r5HfcjNsVkHzoVh4u3nbi64l/UrseF3iQXEBECnBTN
XjUZxW9fd0kAttNtGy7I6Bkur88UQuHls+dmDsg4ugLlxLaNgsKMAX8XheQ3Yk2I
F6ktUuvJtCHYgGGAS/iu8Umlx2t+/huWRiEKIlp/Ft96Nnh+IqEl2Ny8El4nqNCZ
S4qGl6kNrUN1jhQMOVjOTLQSn4TZyJR5uMaJ4kknrPDeaRdNtrpz3e0YAgc0FufW
LlJzUx6RWQiyfXJYAWqQG+Kdj3JJ7v6nJePzZAHfFdDwY8nd369W32zXJGvmoL2J
3ieAUvxTTVjVKZzles17W8W/4jpvHj0QiaIx5RMRuLJXAmx4seGdB42vIHpviPbv
QJLz9DDI9Aof1zUlXF01fSOIInXXj+KTeIMhjYKrfwVyDXvByG22kpgrrlEAWRQD
cq0j7v2wAHJZ2vGHyTxpJLHruIjE5yGthAm8Nnfutey3Re70YKQ+VcdF0aYo3nMB
kj5BsuXk0lm9A9C+craKbmnnhog3j4lHhnsVac3fsSdupm1TQlg=
=GNZu
-----END PGP SIGNATURE-----

--Trx6kqpy5WJ0k5aw1kWN52k1y2o1CINuq--
