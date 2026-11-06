Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997216;
	b=yplfmvhfM/XALLuN04XNUJyAmIl/xIY+L5ksFLsBxpDJPrjkgXCuI6GtvFtSUerdDFNc
	 T+ZzEGvpkWx7wWG9sP8/uUwHUE0ORybdk0qbtsIfKWioeKddE5cDsVkwFcLqWLnlccO0l
	 09pcZ2OYKyl0cFkzTwA6Hc60r8TCe3yyOujh3s2XTeYwKudDeXBvS2NIfGZ5f5EmsrJ1l
	 fvXmOnJbqtSve8JZcMktL+9YZcLL/QvCq7a/A4J3NdVzAe7Xi0zgnXgfXVEGXfJNIT9bN
	 tY5tQRnUCkc91kw0z+A241mI5JS5Nlh5XZOuAhYY+p3EqHzYmSnJFhksaH1fzE1w3sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997216;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Cu2WHrvKDwrcNjSfIEH6DUYjHqV/hZhhHfUjDakH7lM=;
	b=EVoh+CJI5ZPMve/VZxVw61Ltf1a+kLN+IWDl3jC0y9/zDKSkKGiKlHayS+CGsCEgp5Py
	 gdrDW/nbyPousfkc/TLbbdTe0NdfcPJEcL6wROZVO1cZDVKkY6qqGdAWsf8PWr559r4CI
	 aeTfmGsXd1wJ/oDuY9rQ1rmSeECEpFEsg9cT8mznKUo8WHKjLXciTf0jI6BcdNerXBszw
	 jOvVAwpp6qLpElikvDOFCckaloJ8zZ+WKYi3CA71ladKFHHo+ZDS17QQaqMg0wg7Toikt
	 3uSZtv4/ivpBFbHUT3kbFKeCAEeBFESo3pkCAZVNpstyOiGGsZ+hBZ9JZaPGSRrsuyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gLf444uA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BC9606A32E
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 20:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gLf444uA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08311F008A1;
	Fri,  6 Nov 2026 20:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793997216;
	bh=Cu2WHrvKDwrcNjSfIEH6DUYjHqV/hZhhHfUjDakH7lM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gLf444uAJqYSh3Wg2lLjnTTNdHIM92e9JE+crZlMrfUMV8EMOQsH3eWh47fJDW35h
	 9ggL26kc2hS+uOq5xRP0GwPhH+wqEYqsju6Mvz9VNJWDI+XX3EKT1b73uxjtIti85v
	 wvRDdlxpAQ1kbsiZN9MdX2PN+UCBEndtRA8Ghgw2jWHqOZnxFg6+cQxUh6Vt9ABP/Z
	 7A0Cr+qlWZJJNHViBYqt5ECoxWxxwAMHg+X9KpD1HDCY/UI2hCVWiG1HzE+uf3AFSU
	 9nz3xCmvWXno4ZHOs04YENdIXYT8vtfYUOT00129C74VUBY58AkEL1TA0jInvPZ+Aq
	 H3ya6TVKux5mQ==
Message-ID: <sashiko-outbox-202217@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 04/15] s390: Use the common syscall table
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261105-tonyk-syscall_table-v9-4-8d1275885d9c@igalia.com>
References: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com>
 <20261105-tonyk-syscall_table-v9-4-8d1275885d9c@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 20:33:35 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Remove some of the duplicated code by using the common syscall number
> table.
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-tonyk-sysc=
all_table-v9-0-8d1275885d9c@igalia.com?part=3D4

