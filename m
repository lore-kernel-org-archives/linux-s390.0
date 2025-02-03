Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A15020E6FC
	for <linux-s390@vger.kernel.org>; Mon,  3 Feb 2025 20:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738615680; cv=none; b=l1fbx6EArg3mUhmgCmgVcRs24+AdHAE+gasYbtS9Wp8oNoItmEVtLga9W+0QshXj0blqDACGlYNrNuYYlKjSMDhAMxK45NhtgV54ScCZa22xRsk8YIz6/m5uRtETPYy7H/0esbqW9F0KhUHgsrU/uwhfY35P8IYi/d5GmxWulAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738615680; c=relaxed/simple;
	bh=ywnzp34WhCW32lA6F155Lu1ROxDUDRQ/w3ltRhb4ei4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qA0qnkHo3kzR6DnALPSsemAWdUfjbmjjPDrScAet0jxXroUmOYy9uXdak8u9Fi4erkSwp9t7hf/ayY/+qI6zNnQdYaybFYwGrCJCDM8ScR7TAoRWmHbE3oX0TGh0x6ZvB2z0YFTZqPHnF6e6RsgG5qM4F+6W0w+1suhHW+yS8cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LHLlKl1x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHLlKl1x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738615677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z23hnSVRDdLtu/YfSEOy1ZPbreF7qu2IDIJvuaUgh3Q=;
	b=LHLlKl1xmXuZueKyGhZa/pwsXBmf6v2JYEXYtm8cJL8jvG+aO+soFb4hAM4nR0HSqapYwA
	1892T7qxI7k8rtVmLBLvheEnUhctEPy1euLLPugjKTztYNGorp+xVcGyNJAva8j0CqHPrg
	yYe/nT1Zks3f0F3KhoovQzx8AhrzyCk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-ov031NymN_-bB7gvk1Ms6g-1; Mon,
 03 Feb 2025 15:47:56 -0500
X-MC-Unique: ov031NymN_-bB7gvk1Ms6g-1
X-Mimecast-MFC-AGG-ID: ov031NymN_-bB7gvk1Ms6g
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 591031801F1B;
	Mon,  3 Feb 2025 20:47:54 +0000 (UTC)
Received: from [10.45.224.44] (unknown [10.45.224.44])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D473419560A3;
	Mon,  3 Feb 2025 20:47:51 +0000 (UTC)
Date: Mon, 3 Feb 2025 21:47:48 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Harald Freudenberger <freude@linux.ibm.com>
cc: dengler@linux.ibm.com, ifranzki@linux.ibm.com, agk@redhat.com, 
    snitzer@kernel.org, linux-s390@vger.kernel.org, dm-devel@lists.linux.dev, 
    herbert@gondor.apana.org.au
Subject: Re: [PATCH v3 2/2] dm-integrity: introduce ahash support for the
 internal hash
In-Reply-To: <1743b5fc-f401-c416-5733-6757bda963ca@redhat.com>
Message-ID: <54225db0-1baa-df65-9311-d31f7adc75c6@redhat.com>
References: <20250131100304.932064-1-freude@linux.ibm.com> <20250131100304.932064-3-freude@linux.ibm.com> <1743b5fc-f401-c416-5733-6757bda963ca@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12



On Mon, 3 Feb 2025, Mikulas Patocka wrote:

> Please, send a new version of your patch where these problems are fixed.

BTW. also, increase the target version number ".version = {1, 13, 0}," -> 
".version = {1, 14, 0}," when you add new functionality.

Mikulas

