Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D6C21D5AA
	for <linux-s390@vger.kernel.org>; Tue, 21 Oct 2025 06:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761029614; cv=none; b=ZE/aBQpNorxzBLLzsSmTG7hX6iGwWDvgDIBU7GY0Y7L6R1JNv/jj3QS486lnzgflYw44DjcL8+SbzRcPoAs1KFvr4ajq5+2Id09h/1g1thQo9uUBGVkiFGW0Jwr69KFhDTGufBYmupkcaDjYC1ZW/emi9mwUEm5/E3YTTIvvCrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761029614; c=relaxed/simple;
	bh=b5Oxy0aVDnQn3jn8u5FYY7eN2pD09HkLoZ7gBZxrHHQ=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=UeHWBRc6DzSb1GOGYAJoq8IOUJw3vhlU3n12F+JUkh99mc3WUA1qJacjx8/hmrwqBRBiUmF2R17qD8YBdQx2ypzl+NJ46f9jUbidJWALIZoU6Y0Kr4QItOcXTUkXr0BdkxQytDkdxieXhP1vZEElxbGPCHKy1hW1KFYP6uRMOT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NLRBtwyP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NLRBtwyP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761029611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ie+W55aaySDpp/ujiBmo1lpU2QKHOUUyDBu+hkl9G/c=;
	b=NLRBtwyP4DXxenkfv+jSqyR2ZvTavk9aWo2pEGlRCriroOAn29ZQE2gkMhJt5K0rAtxKzG
	krddl4thc8t3i9m8BzX4hbed7BEIe7yPpYWBsSpRxpCp7iIrf5AAERWjO1F5pqjg/x9fc/
	2oRoLm6DqbzSjaXOAfG8OEz2FXh55YM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-y8__IppnOXib6TI3-h_FDA-1; Tue,
 21 Oct 2025 02:53:28 -0400
X-MC-Unique: y8__IppnOXib6TI3-h_FDA-1
X-Mimecast-MFC-AGG-ID: y8__IppnOXib6TI3-h_FDA_1761029606
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 63B5D1956067;
	Tue, 21 Oct 2025 06:53:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.57])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EF088300022D;
	Tue, 21 Oct 2025 06:53:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20251020005038.661542-18-ebiggers@kernel.org>
References: <20251020005038.661542-18-ebiggers@kernel.org> <20251020005038.661542-1-ebiggers@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: dhowells@redhat.com, linux-crypto@vger.kernel.org,
    Ard Biesheuvel <ardb@kernel.org>,
    "Jason A . Donenfeld" <Jason@zx2c4.com>,
    linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
    linux-s390@vger.kernel.org
Subject: Re: [PATCH 17/17] crypto: sha3 - Reimplement using library API
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1431989.1761029594.1@warthog.procyon.org.uk>
Date: Tue, 21 Oct 2025 07:53:14 +0100
Message-ID: <1431990.1761029594@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This needs to modify Kconfig too.

 config CRYPTO_SHA3
 	tristate "SHA-3"
 	select CRYPTO_HASH
+	select CRYPTO_LIB_SHA3
 	help
 	  SHA-3 secure hash algorithms (FIPS 202, ISO/IEC 10118-3)

David

