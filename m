Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2850C31D757
	for <linux-s390@vger.kernel.org>; Thu, 15 Jan 2026 19:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768505924; cv=none; b=ludy+rlfJwxKogMVStuHZv6QWyCzzs2cBPaajztWEozOM8S7W5TT54umMf6b0nK0xtTBwkEvV2/n0PHJeV2Bz9i8ErdP9+v0Any01Te3GDuwshw32ZWxMoxjO5WWMdAlVHOegiHRHSboGgIdsjvTA5/wAM7z4hpqgYccgeJ9iTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768505924; c=relaxed/simple;
	bh=BVuRcIp9C9aDs7YujmRCIsJWyiCOSqmqC7FZNs5wMUU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=vCSxHWeSa+2u+Tll/weyJssxW45/OeqXx57lNSlTM1AkSPUAtxJRBqGL5BdkL0lqquiBRaRmGXWi7KPKGaOjp3PuMSh3HceE1YUl0Bm/8PuJBFkwSEpUgnNGq8rVVbkwGK7Ifrx66BB0GKjwmv6HfQ6ZJtfSwxgapdvksZTC+uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oasis-open.org; spf=pass smtp.mailfrom=oasis-open.org; dkim=pass (2048-bit key) header.d=oasis-open-org.20230601.gappssmtp.com header.i=@oasis-open-org.20230601.gappssmtp.com header.b=q/v4lwiu; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oasis-open.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oasis-open.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oasis-open-org.20230601.gappssmtp.com header.i=@oasis-open-org.20230601.gappssmtp.com header.b="q/v4lwiu"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c5386f1c9fso201041685a.1
        for <linux-s390@vger.kernel.org>; Thu, 15 Jan 2026 11:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oasis-open-org.20230601.gappssmtp.com; s=20230601; t=1768505918; x=1769110718; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BVuRcIp9C9aDs7YujmRCIsJWyiCOSqmqC7FZNs5wMUU=;
        b=q/v4lwiueAYgwKodQEcCDXPv10NKMiKAkdhrE1KcqwG2Ar7xntyck0JZ5SM9ZExMMd
         zMQALPG+JapU5b3rZqRiEk5GMoIMYfTqFPHGHIvMKSDHtBpeAvfMDTP0Egml6WR0RJs1
         lg3KWp8MmHiUIwCaBB75Jz5DqrybBcXYUAd2Wecx8pJVJiRSCJVpi0aqnazLEYas9wyO
         HuKl9L8l7a4VCPRNcnzQq8Q7PiR8KQLBwKr2/ixq/20QJs0EzF7ljgVQoJbg7XV9Q9Hl
         e7FvNXg4cstjfHUQ9MIv60W8K7OxyV/4k5PfuqQ8/S/SKmzcV0H7eCVKZIqKXwuiuvlm
         mpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768505918; x=1769110718;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVuRcIp9C9aDs7YujmRCIsJWyiCOSqmqC7FZNs5wMUU=;
        b=TANsD1d0SQP9+c+st3LM4aseav5SbIN76OtH8zbD61Sm417nvX9Ih5R70wpRLnZFdN
         5l/yMt+8KLFh2LQYgfmMPI9rGp0+NJk+Ewbn5znJBkOADcu+xknVjCOJ2LyloXfrAUdL
         wdqtFvb2nLuWNjf4vtR8/dhH3CTtNzci/GS8e0IxHy+mJ/ZMbXKDDOauJHnEdl4C/9rg
         dHBxj+/ZAHm3P5ki4sZAz+hyuJLOjGoZhyfXlbXH3bCjh0ngz2Qn8xwwEfgf0v7rpCjR
         UxOtO0I6ZB2WI32Rs8jccwECbap9BUyikR5vOLP4F1lb4HSIXc5iQn99o4fTTensS0XD
         lJtw==
X-Gm-Message-State: AOJu0YythO87KhaOEq5mojH2K24pa9wbKMiLrZgwqZUJfdFAMagnakjM
	T7WM1yQnmOqL0TeOISmzU4rRH7tFvGDziAxp1LyCZKR2F0ebqX9b+YU9Wip7yTjRC8zTOFJQ4JU
	XPrA01WMvgqtknwSHKjsKsgNVOD76D+QSg/3AbBRaXKUir5NeY7KwRUw=
X-Gm-Gg: AY/fxX7skXqK13HBYaLusicifWOrIfHxplusBCkIuzdUYOpiH9owX6DzQ1nusK2e5ey
	VWVzEMYHcbA/3yDKmnjzvo19wyzvRbQ8CWRiQDXlJvw2K8Z9pt58lYDNtvS99aNTj93rHb86W3M
	wSsG4zWbWZM8aQrOEXQqaK5Yi8akofaG+pjkMRgBzS2vdnHdIbN2SPC83QAAfieu0GMRPd0SmkT
	8+tBgXRjWY86Imob6glvE7ES0gfOV42M8VyVdgdhK0jsq4hjnUu8TwlZA4drBwb3qMKn1OnVxTe
	Nl44rZXpJSvre/eRT3ILndBBIMiZC7HK5yD7OPsW4jUxPkpr36FUebAuhx0+RlLQLYB/FkI=
X-Received: by 2002:a05:620a:4586:b0:8a3:87ef:9245 with SMTP id
 af79cd13be357-8c6a6979ebbmr72473085a.85.1768505918116; Thu, 15 Jan 2026
 11:38:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kelly Cullinane <kelly.cullinane@oasis-open.org>
Date: Thu, 15 Jan 2026 14:38:02 -0500
X-Gm-Features: AZwV_QjK3LSuFcCxr9yvTsWW6MdNnQldjWALCDBWPzThRi0Bp_YLiTdR344P-CQ
Message-ID: <CAAiF6009w7KG+X-+bgtBvHDz8WFP7E5ovYVTB7Ki_WJRpVyngA@mail.gmail.com>
Subject: Invitation to comment on VIRTIO v1.4 CSD01
To: linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

OASIS members and other interested parties,

OASIS and the VIRTIO TC are pleased to announce that VIRTIO v1.4 CSD01
is now available for public review and comment.

VIRTIO TC aims to enhance the performance of virtual devices by
standardizing key features of the VIRTIO (Virtual I/O) Device
Specification.

Virtual I/O Device (VIRTIO) Version 1.4
Committee Specification Draft 01 / Public Review Draft 01
09 December 2025

TEX: https://docs.oasis-open.org/virtio/virtio/v1.4/csprd01/virtio-v1.4-csp=
rd01.html
(Authoritative)
HTML: https://docs.oasis-open.org/virtio/virtio/v1.4/csprd01/virtio-v1.4-cs=
prd01.html
PDF: https://docs.oasis-open.org/virtio/virtio/v1.4/csprd01/virtio-v1.4-csp=
rd01.pdf

The ZIP containing the complete files of this release is found in the direc=
tory:
https://docs.oasis-open.org/virtio/virtio/v1.4/csprd01/virtio-v1.4-csprd01.=
zip

How to Provide Feedback
OASIS and the VIRTIO TC value your feedback. We solicit input from
developers, users and others, whether OASIS members or not, for the
sake of improving the interoperability and quality of its technical
work.

The public review is now open and ends Friday, February 13 2026 at 23:59 UT=
C.

Comments may be submitted to the project=E2=80=99s comment mailing list at
virtio-comment@lists.linux.dev. You can subscribe to the list by
sending an email to
virtio-comment+subscribe@lists.linux.dev.

All comments submitted to OASIS are subject to the OASIS Feedback
License, which ensures that the feedback you provide carries the same
obligations at least as the obligations of the TC members. In
connection with this public review, we call your attention to the
OASIS IPR Policy applicable especially to the work of this technical
committee. All members of the TC should be familiar with this
document, which may create obligations regarding the disclosure and
availability of a member's patent, copyright, trademark and license
rights that read on an approved OASIS specification.

OASIS invites any persons who know of any such claims to disclose
these if they may be essential to the implementation of the above
specification, so that notice of them may be posted to the notice page
for this TC's work.

Additional information about the specification and the VIRTIO TC can
be found at the TC=E2=80=99s public homepage.
