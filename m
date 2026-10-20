Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792494314;
	b=WcFcwwS9wgTvKKWILhInoMBfdiVjHHp7jvq1FYWlCiusEOqKuELqRW9nbJk08q3shSnu
	 UFlIAJU7lo2y4twy1S9YR1777ToBXNCkB4Is+DfbZpUkouHO/fyI/p2S9BC/Uw7XmEL1i
	 VOEbSj+5W8Hz3VSvorLWjqKcAfLEmHoZudSoiuz2hgC9xOHiQ+ZQfgXPAra3uPZVfRhkM
	 VlcTUT+mVBYJUyAXIh6ApBETZJ9HClPdx7bvCLR5NCq9LgR+SpWazWOYd8+JSPet72P/c
	 /v2pVyN4HHnbeBd3krKvm+NwWhUu+wI7zBKUpj+IgUhNkus4ZIRQdZmXgs46jxbTKpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792494314;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=fLmuyTfd7g4VErTxnTfok7Jz/5L33bdb9HtzrWwzsMQ=;
	b=M3Zx1BoUDhbB7MlagSolK+8GWA2nXAJ/jZoO9eQ8n0DMQ52cAaJvCBWUtdswBRLZu3B+
	 VFaFNr9Uw1B1DVwSHVfknawdrYg/gpGD3KcBImrViUc8eXkccMdsm/3kC/csoKIj9tPWC
	 hGLwXL7fChGoFGxH8t0HBqkBqM4o7w9Ds+XkA0sWzHjCM5YOYKd1N/TJ0RmbibXbT/8ru
	 2nDqqbrYX33xfwc17HRQZ+QjDVWciIm2a+OJBbJHOC3SToAhxtI9ccD3nKAfM7E6pRAFG
	 69yHi3ud03U7/BcQf0onZNukJ4uDOYPaz03WDBKWg+UBA0CYJxTHIi3u1CPyAeAdCCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QJjFNxih;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0154606A329
	for <linux-s390@vger.kernel.org>; Tue, 20 Oct 2026 11:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0154606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QJjFNxih
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792494313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fLmuyTfd7g4VErTxnTfok7Jz/5L33bdb9HtzrWwzsMQ=;
	b=QJjFNxihoNUtAFLgrq7DdCWBrFHkxp0r7yvxsbqLF46cWABp4FrLvEiPJQEKWW7ZHGJ+Wm
	0MccmtIebgfU5l8P0DrWtQYjt0cw43ErgjJo1YMNpPYT3uQ0Av/Q15c1FYr6xPMpzZv3GR
	X8kmHwONSU0R1gKaPo4N9oQZw+jAgDA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-m21zt0reOCemHoMKFmPGmQ-1; Tue,
 20 Oct 2026 11:05:08 +0000
X-MC-Unique: m21zt0reOCemHoMKFmPGmQ-1
X-Mimecast-MFC-AGG-ID: m21zt0reOCemHoMKFmPGmQ_1792494306
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F981180256B;
	Tue, 20 Oct 2026 11:05:06 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8D09318002B1;
	Tue, 20 Oct 2026 11:05:02 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Tue, 20 Oct 2026 13:05:05 +0200 (CEST)
Date: Tue, 20 Oct 2026 13:05:01 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Joel Granados <joel.granados@kernel.org>
Cc: Allison Henderson <achender@kernel.org>,
	kernel test robot <yi1.lai@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
	wireguard@lists.zx2c4.com, rds-devel@oss.oracle.com
Subject: Re: [linus:master] [sysctl]  8d75c338f0:
 BUG:KASAN:slab-use-after-free_in_touch_wq_lockdep_map
Message-ID: <atdK3ZkT4YqjGICq@redhat.com>
References: <202610190310.9737b2e3-lkp@intel.com>
 <atYB0bm9eEXp8A2g@redhat.com>
 <atYW0K3t57puHeLW@hobbes>
 <atYuE1xnVYe0BDG4@redhat.com>
 <atY42k00k0Waj6o4@redhat.com>
 <42964fa071bd8dcafd418c89be6d66856def4dc5.camel@kernel.org>
 <atdE-TB8hkqcwp6g@hobbes>
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
In-Reply-To: <atdE-TB8hkqcwp6g@hobbes>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 10/20, Joel Granados wrote:
>
> On Mon, Oct 19, 2026 at 12:52:58PM -0700, Allison Henderson wrote:
> >
> > CONFIG_SYSCTL=n.  A simpler fix might be to just handle the NULL at the
> > three call sites, e.g.:
> >
> >         rds_sysctl_reg_table =
> >                 register_net_sysctl(&init_net, "net/rds", rds_sysctl_rds_table);
> >         if (!rds_sysctl_reg_table && IS_ENABLED(CONFIG_SYSCTL))
> >                 return -ENOMEM;
> >
>
> Remember to NULL check rds_sysctl_reg_table in rds_sysctl_exit(). You
> might hit another UAF on exit if you don't.

Why? unregister_sysctl_table(header) does nothing if header == NULL.

Oleg.

