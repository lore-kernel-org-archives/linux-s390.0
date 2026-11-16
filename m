Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828271;
	b=p91k1lFxB4nPt0avqoCUptYE4jKsxGKwY0XNQEjMO+KKkqsHQJqDkX6n/XANFrlr5LW9
	 J99jdB5oGtCLMJDCOXo3WztWLwBwGqaNYY1eZjckYzP9P6lZbH+bEhxDAr58mQqTJ7Enw
	 gWFaWEQLOOAth/Y2CRKTLByVS0ctuvTF8SIjxp4MKYqJXta9e2jQVnwvw9z/eT29MI3mx
	 nbOkooS/DudHpCBCQFbku/Bc3aC+x8Ggcb2hIXVPPvXDQLD1jTrZWJ6UwS1QNMu/cUK+p
	 OMPHze/XhYxLsM/3AdzcNPOeHFgXyohzUnalmJ1L7v0gTnbl3wTJkTMfU+lqGnSkknA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828271;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=n8g8ZYvf+P2kVT9wMlYmjy+y7/rWfgt5pqEhF12D5QM=;
	b=2l2levZ4rnv9BRdj3ggtA0llO8xcZEX+NmZkclH90mnQ4VRmYmfX6YrBzjVrq9nFy3q0
	 407SKX3FA6AzmS+dMJkdnKdggbQuAViQry9nIn9MRdiy6TtWlxQiPoSBDXg92zrTqzh3k
	 CnhKfCSE5kg2hahzQ6rOJoFBXKmsKpp+hjFvPAUOwZmvJ/XRYj2q4nU0jBSvXsKbTi1SC
	 f1Tn5sQDimWcYdO66plUfILvhsIkn1ZwSdJzPoe9WhOze1fdIW6DwLZwVnLw407QKaoFM
	 9RURtrADLQlFgmytiZxgBkNtgFbBNSW3Dj1na1I6gg8sN0OYJT0259Otg1sAker/uZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iDeX2eCd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EC7606A339;
	Mon, 16 Nov 2026 11:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iDeX2eCd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71A91F000C4;
	Mon, 16 Nov 2026 11:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828271;
	bh=n8g8ZYvf+P2kVT9wMlYmjy+y7/rWfgt5pqEhF12D5QM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iDeX2eCduwwxzQ71pSVITxITqHmntMjHUWn4J/O+jStg69RHkqwTgImR9q3ky+ncs
	 QcRoAO3BgdEeJCAfyyAVeKXtbnPaNnZde0lfcHbjsewrqSCQ452vyWuSdxuYo/iqdj
	 i0ViiQHHaQWV4aWrp6x1B/hKYEHZTLG/JIW3FtPgNCnLwGn/5Y3z3qwnPwL5KxrvB9
	 vapqUz7JXN5ZsynvOHoerqiV4sw4ARZabAHoOCpyg1/EXV/NFd2FNfeSGcPhBwfRhF
	 RKrxgL78Q7he1P/obmAA3Wd4V5qYUQkYwij5z8yeHNhCoQJQXiAEo+FqceH1KTJmlt
	 P84zXzudTc7Wg==
Message-ID: <sashiko-outbox-216912@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 38/44] nvmet: refuse files on pseudo filesystems
 as namespace backing files
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-38-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-38-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:24:30 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> The file backend takes any file that can be opened for reading and
> writing. With buffered_io=3D1 that includes files on procfs or sysfs which
> then get read and written by a kernel worker on behalf of the host.
> Refuse files on pseudo filesystems just like loop does by switching to
> file_check_backing().
>=20
> Note that the helper only accepts regular files and block devices. A
> block device ends up in the file backend when buffered_io is set. But
> so far the file backend also took anything else with ->read_iter() and
> ->write_iter() such as character devices and FIFOs. The size of the
> namespace is the size of the inode which is zero for all of them. So
> such a namespace was unusable anyway. Refuse them.
>=20
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Tested-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D38

