Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AB91D90B3;
	Wed, 15 Jan 2025 22:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736978819; cv=none; b=tJawk86f2c1l4ghMD90A5BDgkrCQvOZcj7597m+ErHnGWnF5fq0C68+bhR44pXWusmy03cX+mmgdwUu3+xnqxflS5L7u4XUFi0Qk+Jh3vYw3AKJ+c/d5/LvCaGOr9YNPCPHGjKbrj3oULQvXPRF5ajy1VVpC8PM081bvAAZMBi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736978819; c=relaxed/simple;
	bh=nm9E0p4LIeGTehuGx5B4Bv0XymvRys2UeFjSk72px2o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UqSSTrGi9DgtnHooMxNW83xFxwyLw1pJakrkaJUQ1A+F8Y8MesMK6QQVuQeY+D9/tZBBKyHbN0S9iJB7XZMdRqB4qAOMfzXTiyD0lxFgdYQZ+/vQsvPK4M05i1538Na1GDuPcqKLssEpCb7HJLnjX9Az/1OarUm/y3gNQaam3YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CwZbpjjL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CwZbpjjL"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FHX4qq024412;
	Wed, 15 Jan 2025 22:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=urlAdT
	ys7/q8kAgE4YVyR4Fc4aIGBxgImaHxBvJDnGg=; b=CwZbpjjL05q0+XfUZouy2v
	6CLiLeMsRx3RYq+9auDxMtuvZqalFluwDirS+/5l/CPdYEnNUe6HRc2EzMFjDcAM
	CD/0kGjOt/Gn+3TKUCjL0K0gAE33JoZqu/vmvfizplhaG4DbR7sdqYjCwzXtHVx2
	JxbDHqw2m/P9NKxjaWrnF2xUj73clZPT75SAUo1iCTe8kvSx1uYkY+aA1FdSJ3l2
	HxIs2hfE9+IioqRgiJUhz5b/FmTajTMkDyLxck4JZOBTJvFXrYodNDamExtQuP+g
	G4kQvNoL+8toQc0YZoKhIO+2pJzq4ioc0uuaDmlAaG73ZPpakUpLn/O/YmfC/ibw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44622hwh5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 22:06:50 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50FM6o2t010430;
	Wed, 15 Jan 2025 22:06:50 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44622hwh5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 22:06:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50FJ4t8P000881;
	Wed, 15 Jan 2025 22:06:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44456k2dem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 22:06:49 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50FM6j5S34275598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 22:06:45 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C75BE2004F;
	Wed, 15 Jan 2025 22:06:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53C7C2004E;
	Wed, 15 Jan 2025 22:06:44 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.34.169])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 15 Jan 2025 22:06:44 +0000 (GMT)
Date: Wed, 15 Jan 2025 23:06:42 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Peter
 Oberparleiter <oberpar@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric
 Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Julian
 Ruess <julianr@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily
 Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>,
        Halil Pasic
 <pasic@linux.ibm.com>
Subject: Re: [RFC net-next 4/7] net/ism: Add kernel-doc comments for ism
 functions
Message-ID: <20250115230642.0fe21fb1.pasic@linux.ibm.com>
In-Reply-To: <20250115195527.2094320-5-wintera@linux.ibm.com>
References: <20250115195527.2094320-1-wintera@linux.ibm.com>
	<20250115195527.2094320-5-wintera@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lnsDvFPvhzIHeYnksvk7M6uFuLxXxoN6
X-Proofpoint-ORIG-GUID: m6BHoGvvCq3CWH1C5sdDrkrbZxD6JIB4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_09,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=773 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501150157

On Wed, 15 Jan 2025 20:55:24 +0100
Alexandra Winter <wintera@linux.ibm.com> wrote:

> Note that in this RFC this patch is not complete, future versions
> of this patch need to contain comments for all ism_ops.
> Especially signal_event() and handle_event() need a good generic
> description.

Such notes don't belong to the commit message, but to the inline cover
letter IMHO.

> 
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> ---
