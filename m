Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE871A38F9;
	Wed, 19 Aug 2026 02:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787107012; cv=none; b=K85fvlrAk5OkBdol3zAHLlQLZ3PW3MBO5A4S1yRupCTxKD1/ZacW5R8kqdRc+B56Y/8swPUx4lbD9T5oH6cdQzj0hZhI7ssxJtrLg/XQ9LKjjHynJ/DFTY6Z54iWLlq/D6PG1HNd6VMS9jNl/TM5NMassHXLHbmh5ta4DuMeMyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787107012; c=relaxed/simple;
	bh=MVKro3nI3H36PwjoNzLlA8VzY8nSI2bvSRY7KmKFZG0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IfkzXKw7v6ryt+XBnm9FI+LbwDAXe9E3j1OVNrj/IvNcGJBQrBoG7HnhEUFNYrQo3OL/vvWZWz0VAWgoMOscNQemipHSVHWtYgnuJ/jWYQWOjupOp33EvRYAdmOIYWn3y0JK0yFiXiPNx+GR7+8EF1Wo286Z7xGLq6if4qKHtdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBeuDpEu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBeuDpEu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4C01F000E9;
	Wed, 19 Aug 2026 02:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787107010;
	bh=MVKro3nI3H36PwjoNzLlA8VzY8nSI2bvSRY7KmKFZG0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BBeuDpEu4NKW4l/KHI1e/LiyVeNH3Tc7bBEa2mHwcrrJVihV9wV3YoZGEgGN63uBf
	 sx9yEw6XI43ifGkNXaZPZXVPIK55FuuWbWMGV/Um49VWD+8K/FlWkjCZXWwi4c3XVX
	 +x0Ni7C1Vrdh96YX5UJh38X9qQzOj1hehXSwIItbPeLlMk4fwt1HzwOaramyZ+2eoy
	 gk/jKQpPzs5rSVzpyxs1YNIQgn9/0IGjrvFoCYASwjtO8/iZOZAn4vDQZ+eGNI/CLS
	 0UECbovQFckuOuw+MRVw/1UsSQ2yZ5MAQUHvZ2BIqLYU2L95LzhgRer81cPBZr+eVe
	 jfpARuHIiKd5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 09/13] sysctl, ipv6: update
 register_net_sysctl{_sz}() callers with template arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mauricio Faria de Oliveira" <mfo@igalia.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, bpf@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, mptcp@lists.linux.dev, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260818-sysctl-module-aliases-v2-9-d5a69dae5798@igalia.com>
References: <20260818-sysctl-module-aliases-v2-0-d5a69dae5798@igalia.com>
 <20260818-sysctl-module-aliases-v2-9-d5a69dae5798@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 02:36:50 +0000
Message-Id: <20260819023650.8A4C01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The sysctl table definition and registration must be in the same file,
> in order for the macro to work.
>=20
> Add plumbing to register ipv6_{route,icmp}_table in their own files.
> With this, ipv6_{route,icmp}_sysctl_table_size() can be removed.
>=20
> Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818-sysctl-mod=
ule-aliases-v2-0-d5a69dae5798@igalia.com?part=3D9

