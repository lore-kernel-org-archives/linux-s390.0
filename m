Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B693FF1B4
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 10:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851068; cv=none; b=o4RMe6wmJpOvGBWYGstXyHS/bobYSSxLUKkBsWlOEwHsVTvDvQjMPXNW4PSAHIwN7SysZOhvo0DeaRjRAuiYEvt87kS7VF1GZnSCOlIDaeGLEN/oBcFSflOIN0I0o2OgHEPLhBPTbXPbyEPee7As7gND9KNVZa9JOcKMNWgCyWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851068; c=relaxed/simple;
	bh=n1IYuoCNm3uWwcJAojhFbNkIhQf2IexsGfEqIoHYvYw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SYiQyvwfcOBOZdnaGDOu06RFUFa5IgoY0E0/+IgMeG7xkM9Gg6QM/3BTlZQ3u1uTOhw7YT83RAmzgJ+WIov90usFFhbDu/607TkvHlCShRSl6PZGKbQEeA2lIVIqdApzgpLjcx5uj09Z8IgKIfsS5/67vNdYp047dIEsjIbqos8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/NjUnnY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/NjUnnY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F261F00899;
	Thu,  1 Oct 2026 10:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851061;
	bh=n1IYuoCNm3uWwcJAojhFbNkIhQf2IexsGfEqIoHYvYw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d/NjUnnYBjcVqwCUPzd7zn4FcD+JJbkxekE3IkpJ1jQ00EgGuj1wqHN57rXmXXB8E
	 XTOzwECCTXqPU+yQs/CyA2p28E6bHAZOBIRIzUX4dwacVnJQd5O9QntH/k9a+QgUhs
	 VZ7J8kxP+Y0w6Xuo6ihE29FCCsRvRydvFWfpnu1nPOe+gEJ1dL6GErOMep2xlsoKkC
	 k/cspoF1WZjjzXoQvuiaIsCYyHA8XbdKzSqidzEuKpzN5jpe06iD+7khbIo78GV1L+
	 iNWwL5ruJ3KzAhWJNYNKyEX96eyE1fhLcJ6lsX68Q8KXTgFAhmBrDGCH+MCXZrgG3M
	 UQUqF0OUv90Kg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/32] s390/tools: Rename gen_facilities to gen_bitmaps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-6-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-6-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:37:40 +0000
Message-Id: <20261001103741.79F261F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Rename gen_facilities.c to gen_bitmaps.c and make it more generic so it
> can be used for various bitmaps. Add command line parsing, and use it
> to explicitly specify that the facilities header should be generated.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001103247.1989=
111-1-hca@linux.ibm.com?part=3D5

