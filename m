Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112083;
	b=xeqxKv0zDcEeCCyZMFhfD/kc+G6gIIRLwlLls5N0413lOL2bqaLNID3vuW09U+8J6geT
	 YTSWBJ3kpMdRqeB710qnBygxeDidMFfqJOrLz/kInYIhIZi9tBVjzDdZ3a4ZWrZsYgEwK
	 66xwiyALgFWkwEf2gUb0CqEaJV+GKoyRyQmB8Uimz+SJk5Tf5mQliG9fLCnaro55SEYjY
	 zlOxC74fF8fOF0M/7xbkiQOXNM0iNOsEKCNRmr+li/yBbSliHPRjCzIIsLFImQNW/BRe2
	 mhpTnwA9sW45tetiFd7PcewiuMjrLC2sPZQ7Q5ENcymu1lYk7op0vz+RSLQV/k9FqjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112083;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=v8oGnKqxc51XmXaLSYVMWsoJS5Na61fScx5RhHHxZNM=;
	b=k8HYSq2wWQMK9pYfzAbxRmDrl7zeeqBeOWMDjT0lCzxddLFdziE3de5NQRoICD88sk1V
	 OKDeRgISJbX3rAhq0vW8i0AGYTsHjYI9fjnoI+06XyNErevsTXpEIqOjcWWG4kVEIQ1bf
	 +Y4uaHaSDMdzE88UqRJr6qc6w+0YCRZLVzlFVv/J/rQlCqfkGIkEGGrnZneXi3lAQB+rW
	 JxzxIZJrJ8C14T9Q0JqEuA4luw03/zN/oE49pMDWoQbxqUFJlO8/Un0lIFQ8KheSbKmUj
	 fVua4Bpwge/VB02VB1h7JLSOgmfnM989zCuu0sa8xDeV8kgikkIsDwmPw225LYxqbIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V+OOEcnq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB8A606BA50
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V+OOEcnq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01421F01829;
	Tue, 27 Oct 2026 14:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793112082;
	bh=v8oGnKqxc51XmXaLSYVMWsoJS5Na61fScx5RhHHxZNM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V+OOEcnqdokWsFx73o9vakqWZrPhXIRRiopYfzWZn7GXN1qsiz6Tqdn2xdoZcEGPx
	 /ChPoOI7FrQY8nOTHdYySHX2rEXemr3n/hpNmjr8utv0vcKHtl4TbBuNvh0TasEjdc
	 Ud4cZ4ZWYI8D71MMjjyoJQLhpm3zVZkJ227tEvwccZs0E3P2XHYJftHgMFjZzSMaZa
	 r40kF5Yw0sK1F2sfbTIInZIjcijyK9teNkL7oCrsksNx3nvKJgc5wsiWhlQ/F2uZIy
	 gYiEGQNfXkti6GPyd1G7sgsHTxSAb/zH40i0UT5AmGcM82b3Dof5v2+Gjjjf8I2lCF
	 ECRRKeVS0mmqA==
Message-ID: <sashiko-outbox-186747@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/10] s390/maccess: Remove spinlock from
 __s390_kernel_write()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261027143030.3154657-11-hca@linux.ibm.com>
References: <20261027143030.3154657-1-hca@linux.ibm.com>
 <20261027143030.3154657-11-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 14:41:22 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> The spinlock in __s390_kernel_write() was introduced to serialize the
> read-modify-write sequence against concurrent callers. Now that all
> runtime callers of s390_kernel_write() hold the text_mutex, the
> spinlock is not required anymore.
>=20
> Replace it with preempt_disable() / preempt_enable() and sync_core().
> Previously, CPU serialization was implicitly done by other
> instructions. Make this explicit with sync_core() instead of
> relying on that.
>=20
> Preemption is disabled so that sync_core() issues the CPU serialization
> instruction on the same CPU that executed the stores. This completes all
> previous stores and makes them visible to other CPUs.
>=20
> Other CPUs need to perform CPU serialization, e.g. with text_poke_sync(),
> [ ... ]
> Work around that by calling the non-checking __s390_kernel_write(),
> and add lockdep_assert_held() checks to arch_arm_kprobe() and
> arch_disarm_kprobe().
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027143030.3154=
657-1-hca@linux.ibm.com?part=3D10

