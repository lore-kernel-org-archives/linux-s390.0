Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7107376A0E
	for <linux-s390@vger.kernel.org>; Mon,  3 Aug 2026 10:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785752025; cv=none; b=YfOcIzSDpBuQAe/FFu6VLZAKInA7H4OKq/2TAoboKgSPIwP4LFKxHWcz63Tg9pOK9KfnTYCjj6fCMVCUA7KbhlPodUVkhlMRQbOlO6VYEzp8O4+I0aUtPwEtEJ3o8yhjTYnZB38fongsOWvd5YsER4KALZiHnBpc64KLJ3JUOso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785752025; c=relaxed/simple;
	bh=qyQt6bHLcRAhHQfP66vER8lTsdpRyPhd7uH3pfPQ4eA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W+tqmrzaq6fY7SlZeDZWsJrtZMeIJC7ashmCbdVYFerWv0zUCQ+FGKp82bmbsAXDUGQnka47CmJrNw1uRh4XfPXCnV1IN1lHvopYlV+E6vIIY7sXbzUvPlfYU2pMK8mbBPCVpGHejhwAzH0WUo0EGl0vnRFCxqVA6h3gm6LDzoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUJberzw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUJberzw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FCB01F000E9;
	Mon,  3 Aug 2026 10:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785752024;
	bh=qyQt6bHLcRAhHQfP66vER8lTsdpRyPhd7uH3pfPQ4eA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iUJberzwdPxmptPMoErJ6C6i4tHb6dj90QPyFLArrIoOyOq5gq2rIlx3cIMs5WdAx
	 V65MfacKqmK9MAwmRMQ6Rey78Np00FZiRJhGJtEgclR97MFbw2qDERWtCl8urzXpHY
	 VJu9ykhzj1Q/hGFK1mysi/ikUVNUs6JdOibQcojd08AMyrN+55bBS/ygvGUGbnvgq+
	 VG4v4UPDy7rFFlne8K6yd3eiTOyYJAYpRI0pae/CdVt7xnwws2qZTs+w/YX50om9fA
	 Ap+WliEPuLiHjj8bykqWS5mXBLT6b1Jxr3YYfnAUS5WRIp5vcZm8qpHAqY8IQICLrA
	 0cczlo9G79lKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] s390/pci: Enable CONTEXT_ANALYSIS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260803100723.2343688-4-hca@linux.ibm.com>
References: <20260803100723.2343688-1-hca@linux.ibm.com>
 <20260803100723.2343688-4-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 10:13:43 +0000
Message-Id: <20260803101344.3FCB01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Enable CONTEXT_ANALYSIS since s390's pci code compiles now without warnin=
gs.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803100723.2343=
688-1-hca@linux.ibm.com?part=3D3

