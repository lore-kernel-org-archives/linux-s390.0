Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792501800;
	b=VBugie3Ck3f5piOcV2YbIIWdsxJM0d8+/W+9KBPHbTWyc2Ahu2KLGL0JqROEk7LIUoOy
	 MsmoIxBAX95JJaNt94ZoCIVIYB7+RJp9JMPEQpB0B/8ypFbpARtFr9nR/Y6ZWYJhjMwy5
	 Uk0AVqAIQIUm4S3q5kLBYJXVdJf4fDw+Pn6DWBX/r9UTx3SMGnUJpozn9uYq/Oxb947fS
	 hWeaRVGFHPFMfRUDr3Nl2RUCHwqJl8RBmEHaS7yvmxtzHX/8J4xoXmLDBJaFmzrpsi2cm
	 5UL5uFCUHh5k21hsRLXlQZy1qoms3e1Tdq5bLbopmb7iM9nuM/6mx4vEZVUaxN0n/SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501800;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=r7db5+BopgpcFDUxO3SJq0ATIR0htP6s/SGZniIH6PQ=;
	b=M5wwO1b/Wt7gbDAWXu6hVXpLZM2nyO1qdw4esRPjJ3x3fMo+UKhjW7b8Vg2busjrIS8K
	 OzAwMPwGYTzi+cTVmYUk42XBiXap3UxEhMkV1Aan/S2dr480xo6QoKwVIWaNj5surOJvo
	 qxzrCG2NRwlGKVPEq6BvqiYpcmHpOGAQ8a+3XGmDxMQzNw3viRJhGe4NTAutinwIY+HzH
	 N6POvMCvUMYEW+4/fkTnzvWOxeg6BnqlwCYUPc9mYTNZ3tFExNXz+1LaSfeIuXWoZoOAV
	 U6xsZ9J9936dgTFhhApi7l5+dFqemVC8eEH87p32uQKPkwNQcfmfGwhwgaYbKnjHLDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ke7W1Mc0;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EE7606A31D
	for <linux-s390@vger.kernel.org>; Tue, 20 Oct 2026 13:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8EE7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ke7W1Mc0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792501799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r7db5+BopgpcFDUxO3SJq0ATIR0htP6s/SGZniIH6PQ=;
	b=Ke7W1Mc0lnrI07oae49S76y1JBeB7wiPF4UyxgqNIg41ZA/pdFrg48WKqqG+mXUrQRKlAq
	qbjUrcVce8Lrhj0m5DbTJVRkV6SA7WGUTV2LIUSGFDU4/7CFF9DCIrAphDWB6mjYxhlJZL
	WZfsZovsv9AbQm3G0uY+89wAZbaWbk8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-GjRzZyDDNB-mlwpQ4uaVZg-1; Tue,
 20 Oct 2026 13:09:53 +0000
X-MC-Unique: GjRzZyDDNB-mlwpQ4uaVZg-1
X-Mimecast-MFC-AGG-ID: GjRzZyDDNB-mlwpQ4uaVZg_1792501791
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2A641954B14;
	Tue, 20 Oct 2026 13:09:50 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5CDEB362;
	Tue, 20 Oct 2026 13:09:47 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Tue, 20 Oct 2026 15:09:50 +0200 (CEST)
Date: Tue, 20 Oct 2026 15:09:46 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Allison Henderson <achender@kernel.org>
Cc: Joel Granados <joel.granados@kernel.org>,
	kernel test robot <yi1.lai@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
	wireguard@lists.zx2c4.com, rds-devel@oss.oracle.com
Subject: rds_wq UAF
Message-ID: <atdoGiW_sHlWgOwt@redhat.com>
References: <202610190310.9737b2e3-lkp@intel.com>
 <atYB0bm9eEXp8A2g@redhat.com>
 <atYW0K3t57puHeLW@hobbes>
 <atYuE1xnVYe0BDG4@redhat.com>
 <atY42k00k0Waj6o4@redhat.com>
 <42964fa071bd8dcafd418c89be6d66856def4dc5.camel@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42964fa071bd8dcafd418c89be6d66856def4dc5.camel@kernel.org>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

(change subject)

On 10/19, Allison Henderson wrote:
>
> On Mon, 2026-10-19 at 17:35 +0200, Oleg Nesterov wrote:
> > >
> > > But. rds_init() can also fail even if CONFIG_SYSCTL=y, after
> > > rds_sysctl_init(), so to me this looks like a bug in net/rds/.
> > >
>
> Yes that's a separate bug, so I'll send a separate fix for that.

Let me try to summarize.

If rds_init() fails after rds_threads_init() for any reason,
rds_threads_exit() will destroy/free rds_wq.

If rds_rdma_init() is called after that, and rds_ib_init() fails
after rds_ib_mr_init(), rds_ib_unregister_client() will try to
flush the already freed rds_wq.

But we have

	module_init(rds_init);		// net/rds/af_rds.c
	module_init(rds_rdma_init);	// net/rds/rdma_transport.c

and IIUC the order of these initcalls is not defined. So if
rds_rdma_init() -> rds_ib_init() is called before rds_init(), it
can do flush_workqueue(rds_wq) when rds_wq == NULL on failure.

With or without CONFIG_SYSCTL. Right?

But it seems that rds_ib_init() doesn't need to flush rds_wq on failure,
so how about the patch below? Of course, I have no idea if net/rds has
more similar issues with rds_wq.

Oleg.
---

diff --git a/net/rds/ib.c b/net/rds/ib.c
index 786f39169bc1..cde2d1bfabbd 100644
--- a/net/rds/ib.c
+++ b/net/rds/ib.c
@@ -619,7 +619,7 @@ int rds_ib_init(void)
 out_sysctl:
 	rds_ib_sysctl_exit();
 out_ibreg:
-	rds_ib_unregister_client();
+	ib_unregister_client(&rds_ib_client);
 out_mr_exit:
 	rds_ib_mr_exit();
 out:

