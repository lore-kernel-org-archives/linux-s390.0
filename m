Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8F828C037;
	Tue, 28 Jul 2026 01:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785203137; cv=none; b=IYFglxmj+9m1rQ8H+8p5ZPR7i1wKGvh3NtvIx3c2sa1Zaey7sPpxJESjmV8haakVjZupPAfSCnnA8zyTXCtZiqT3BZtno6ArVr19dzzai8qp5+QLyPkhLtpTo4i+d/+fDKhcvfw8aMX/MQF4v/IqRhpNlWFvWcuF1jj4RvkrOzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785203137; c=relaxed/simple;
	bh=HWKh5jVdVBQVIVFbLMgfhOQ0eaLaLKsjyGHabuSFMZg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GCynq8o0ZaxNXE9UrfLF0fjycKfkSxM6fEtScO7NjhSi4KEkQhXjCtHZ58wIbQ2680QV//axxy9HkdNPGcNTbR2zLE3T6BIelQvbowwITwzOJuU1gYTCMX5RbGJVAJZEYyOMtC28scXd81v3gfXnNOHJzszmRASuJ+cKYJMPh7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2PDWu07; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2PDWu07"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98821F000E9;
	Tue, 28 Jul 2026 01:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785203134;
	bh=HWKh5jVdVBQVIVFbLMgfhOQ0eaLaLKsjyGHabuSFMZg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O2PDWu07jA4z+htcMTXvplofBYVFIGeYx/SyoIGMIall/m6xhMm8iq43teO4tEnMk
	 KFcGuZAA4erWe6+AQ9XPJlx0aCm1/53TMchaTS4M7S8n4NTFbjXSQHbnDZZajEr7WX
	 JVllWpYtNyjX9xfhONhIauYcw+liD1/7J0O/OiMM83MQVjLxq3RxwrCPOt9xw232Yf
	 XBOA86f1pTPBHlWGK+uDXcpVWTi+xGl3UVr1WyZ6eytReytcC90MMEgdVD5kmRuAsG
	 zbmXgGvfTCKOTjYwjQPF3Z8Vdvv8Wp1D6O4ggYDmFADZL2DE7RfaH1tknWwl1WAfzO
	 57JcJMv0gjGXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 04/10] s390/vfio_ccw: ensure first IDAW remains
 constant
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260728013509.1551753-5-farman@linux.ibm.com>
References: <20260728013509.1551753-1-farman@linux.ibm.com>
 <20260728013509.1551753-5-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 01:45:33 +0000
Message-Id: <20260728014533.E98821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The first IDAW in a list does not need to be on a 2K/4K boundary
> like all others, and so is read separately to accurately calculate
> the size of the buffer needed to read the full IDAL.
>=20
> Verify that the address found in the first IDAW is unchanged between
> reads, to ensure a consistent set of IDAWs being worked with.
>=20
> Fixes: 01aa26c672c0 ("s390/cio: Combine direct and indirect CCW paths")
> Cc: stable@vger.kernel.org
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728013509.1551=
753-1-farman@linux.ibm.com?part=3D4

