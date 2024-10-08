Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFFD1DF26A;
	Tue,  8 Oct 2024 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398176; cv=none; b=LbauHZbOJyUUiGOrQo6AShukthPPfSq3AH1sv8WP7RUuJGknAdK+ZOojLzDS9XCPljbU7Vr199qjNoWMYyF4QWlHjahZehXKCg0AOeqwzQf9HLpLu5rhboNvvpYGPAFJlrVMKBrKMGbK64lKrcavzzD1OWAoMIpRqtAAn64oNLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398176; c=relaxed/simple;
	bh=t68+pIKKc4k2y+iUke8Z1NkMjGV2Eg9xa3InlFZNztQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aurewP+YcKTESloSZfnOGtC7T5CAew/+kyBjuJLe/CiO/ZUkLxLQNENX8KqN04GH1gO6OIrQv1/WvQBPSK5FhgHYUNwbMsb28HG54mbxRkToCbBzwC12ldfG/gDvnt55RiCGgvFJw/fmu+UbSLdYEbKUKKDr1OkjIJANmo5Y0eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YZUnnM3l; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YZUnnM3l"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498DpMXZ012869;
	Tue, 8 Oct 2024 14:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=F1M8eFrTn14sWqu2KswMbADr6GM
	qd529j65ksIvnjgk=; b=YZUnnM3lrF52CDNI1TGJab2zatjqr9u/ItIqSWIWQOF
	Y3BA1u534XEX52aM3kuDUXmKFXDso096CuBrSilwjJCUO7E1pSojhMfZJeRpHmHn
	MsqRL2wW3GOrj7G+tI+HSOEoDnko9Gc88VHLwpl5Qr0Dfn5x76nRcF6mwIBNhJww
	JrJhDB1YlmT8HYdodQLQg4aa1JbEV2lW/vD8YT5NyALzhtUAsYoeWuvnoQPxwJk6
	697yernWOzu6y8X075dVhlQKSZX3KB6l99h1D2PRE2uhuYNlGKHpAVvx2Q1fhT7e
	nbAyVjpPUqFPq0ybwX3Dg8Rv4QDxdTwpdwpqVdSgNJQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4255yvr8n7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 14:36:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 498DxDrN022855;
	Tue, 8 Oct 2024 14:36:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 423jg0vg0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 14:36:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 498Ea9uI55902626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Oct 2024 14:36:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F33F20040;
	Tue,  8 Oct 2024 14:36:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D4ED2004B;
	Tue,  8 Oct 2024 14:36:09 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  8 Oct 2024 14:36:09 +0000 (GMT)
Date: Tue, 8 Oct 2024 16:36:07 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v2 2/6] s390/uv: Retrieve UV secrets support
Message-ID: <20241008143607.27223-C-hca@linux.ibm.com>
References: <20241002160532.2425734-1-seiden@linux.ibm.com>
 <20241002160532.2425734-3-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002160532.2425734-3-seiden@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rSmsmCRdMK6x5BqHmPmugyRrRV61wCB1
X-Proofpoint-ORIG-GUID: rSmsmCRdMK6x5BqHmPmugyRrRV61wCB1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_12,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=461 priorityscore=1501 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410080092

On Wed, Oct 02, 2024 at 06:05:28PM +0200, Steffen Eiden wrote:
> Provide a kernel API to retrieve secrets from the UV secret store.
> Add two new functions:
> * `uv_get_secret_metadata` - get metadata for a given secret identifier
> * `uv_retrieve_secret` - get the secret value for the secret index
> 
> With those two functions one can extract the secret for a given secret
> id, if the secret is retrievable.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>  arch/s390/include/asm/uv.h | 131 ++++++++++++++++++++++++++++++++++++-
>  arch/s390/kernel/uv.c      | 127 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 256 insertions(+), 2 deletions(-)

> +/** uv_list_secrets() - Do a List Secrets UVC
> + *  @buf: Buffer to write list into; size of one page

This is not kerneldoc style.

> +int uv_get_secret_metadata(const u8 secret_id[UV_SECRET_ID_LEN],
> +			   struct uv_secret_list_item_hdr *secret)
> +{
> +	struct uv_secret_list *buf;
> +	int rc;
> +
> +	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
> +	rc = find_secret(secret_id, buf, secret);
> +	kfree(buf);

	if (!buf) ...

error checking is missing.
