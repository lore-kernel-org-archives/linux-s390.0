Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679973BD224
	for <linux-s390@vger.kernel.org>; Mon, 13 Apr 2026 12:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776083642; cv=pass; b=nxhn5r9oytIONKtY0MuVzd0C+J3PaWUZTuJqRTmIGCojOTwEimeeILHKItn4D5jK8nGur2S3TPKxZQhaRmKLYfv380b66bAi9uy9xPls4T8x7gu0ZZWU5ZpbjY7jMXAHyFxbFIBp/p0JnLgQ0ROliGV8XY3zAwzcuOeIxRnaGzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776083642; c=relaxed/simple;
	bh=wNRhK8b7AJyN93ylQPPhEjmZzZeAUBiyh8/nT32Tz4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JtuzVYZp60SRF+RyuTWR6zw8V3LoXTCoAAnm5xIvq9vnIOEGcpb9jAgYe4Dbf0Hd4O7rNZN5HebZicfIeza9luR2ri0MD9/BP6WK9CzfKbmD7rrhPx2NVdxyY0rSfgi5a11cco+D2jeNwZBIcmHb7VTK42MUP/HA6R+K548ULUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BiXWne8V; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MBg9rccZ; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BiXWne8V";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MBg9rccZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776083640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wNRhK8b7AJyN93ylQPPhEjmZzZeAUBiyh8/nT32Tz4E=;
	b=BiXWne8Vut8bZoHVZOjAKH2Oxk+aTkHH69gtkDZGNsjSdvwMJ6Ycc8On7a5IV3o4Q400dV
	dniPtwZw7s/abI7UsIr9GvTVKVuEMYWjennrQmoAKq7Im2/QBeYsK1mi2XjIVWdDAETyzy
	AVqeY5EpMhBay1B7ANHalDIqkkQlov4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-5myWTLXeOjeodRYYpDNPog-1; Mon, 13 Apr 2026 08:33:59 -0400
X-MC-Unique: 5myWTLXeOjeodRYYpDNPog-1
X-Mimecast-MFC-AGG-ID: 5myWTLXeOjeodRYYpDNPog_1776083638
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d789cebcfso450270f8f.1
        for <linux-s390@vger.kernel.org>; Mon, 13 Apr 2026 05:33:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776083637; cv=none;
        d=google.com; s=arc-20240605;
        b=GHCOjNe0uXN9ypojxnjGfAEfkmCSkgwIlYASb+fs+KhPRslGlF9nRgZ2tH7TfxGsiU
         2ggvDKfZs/KpAlALcB5g8vENMiVyWYcofFdeeWKSANjMrGcgBxLzkvHZQA2KJVRqhBMx
         VmwAjwVRDOljxYO0Ws3EPARQ/QNyE5BbmOEznDORYgI7rfY5xKGzqElhJ9yApsG4h5dr
         oBmzwlpwCQSjlR9Sa7I7o+vgZAFLdjuPQnGdgrAY/dbQbidQWgYhvIJlbtfkKTTJenac
         x1D1sX8QsUP43UEFgRervoADshWfhTkBePy7z20I3sTlYyeb1FnzTKNd/DrbgD/Dj2QF
         FCqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wNRhK8b7AJyN93ylQPPhEjmZzZeAUBiyh8/nT32Tz4E=;
        fh=0z6VLOGbuGIh2snoxNsdN7N3RKPZKwcv0b9rOK6WRr8=;
        b=hktJaoP3nT3jVeSzIbijxF03l/HQDNBzJSWupK5acLRl2AsGF8o5GWTwMwaVcBwDnL
         2Y5Ww4LoWrGfb72h6Cl5mcpfosjYzbhgoYjrvUjkudGwy0TqP/6foBQ+uzTNuhUj+Jb9
         LRzqJhgzMAQtrlDG9PXnqJl9PTGLO3FoekYbhtnVySJkFEa3qAkXS/+/JyeeMIIaHV8n
         T2jT5w9ytqM5nKuRAjf6+hxigkm0VTGouPdbr17L2TsjWN4ZHZGFKEk9BdmM10BXCNmS
         zak02tnjj4xqpKjEcf10s19K4aeZkd1SMGDVN6hswaGcoepI2TofVLDbGeWWiZQitV9e
         A67Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776083637; x=1776688437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNRhK8b7AJyN93ylQPPhEjmZzZeAUBiyh8/nT32Tz4E=;
        b=MBg9rccZJzbbCcjzSIs9HbvPP+175dqkKVy+FBrzfS5xbxZBdx8CSebL/f22Bjw4k4
         Hvb18qo3Mi9jgd4TR1rA2p9x3NogNMEvwWfU+v3iD5r56bEyaS40/RhWvPDZL/xkwSkR
         VqUV2btUuN4MrG4ONmOCcuUaEWENFDMEWnDgYsWjRCliwpEY+rjxiH3jIch6rDJ1hv+A
         mrnKQ573wt7hmrEzsr48W6bHsshxTPZTFk9zAkm+V5ma++BpK15dUSlgfM6PV1utqPr6
         rx1vTdSa4XD76Q/Pst0bZnHRImr2Sjacb9icIxo37arcSuzMz+9Zw6inYtXS0g1OkvIA
         pOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776083637; x=1776688437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wNRhK8b7AJyN93ylQPPhEjmZzZeAUBiyh8/nT32Tz4E=;
        b=FD1HIpCF4fMZhYcVhg1baeEGY/tMLTLFbH7iw0ox50WucVz7OiYBqhk7s3KBk7A643
         k1Eo4Qj2Cdz30ga++VH6RhCjb7M0BdktgP4JU3F9W0JLEDe2+wQS2V/GgYEbydAI+JaO
         YhSOiICgZC4wN222rUAncDuYbDRiKyPhT9nfy+rlAxCZNww0NKC4wjH2PZRru7YG0Y0+
         hwjOuiG9SXiZxrtf55Me1CG70+vjIN7zq6oTmaRTVr22I+uH7jpZEwA/jlXjUpjy2y6y
         tlQneusTf1cZjMUEhOSYESHXSI+ScQFKNjUkrKOtVWcN1NeqopxGWpHQdrRfnUww7cIH
         2rQA==
X-Forwarded-Encrypted: i=1; AFNElJ9lMoUKCsE0SVxwZ9MoEfyt+2S/NSvaRgA17kEcHS6bZ74CfnIxKCeOzEGo+AWlsVTdbQOWnBqIr/HP@vger.kernel.org
X-Gm-Message-State: AOJu0YxHZpXqHNFcfDb7ue+JK/EXldcpm90PoKrmkLrKjHz7vG8xVw80
	dli+G1ddRXtroGyV+58bCFLM/K2zU6/AChDOiQo0NR8zI3MOdCkhid2UbGRQqnHlruHGCWoxqes
	fLXDhBzW8kidb2FWoQvp+NW9+DRvPlcyhL9uSvPFJAuIyKFpVadG+ZspZCd32znqF57QLlPsJ46
	ilj9GcnGkQqAaBSrmprxkpQqOHvReGgjSFcVqVosU4BretGg==
X-Gm-Gg: AeBDieuSDcOSarf4gxr1xFvSSdRb6r9urbfFMYgzzrKgrOKgq5/4pNsEr5ZzT5fUf7T
	2SYYlUeAQysSPjm1ybK+SnNmubgqbm6h4pN1kYwKv/t71sUbjVyu6PkmLhm3ZXAk590M7sIUycQ
	Zb3rS1acJp4UrO4vDmJzrnAcEQT3mlqOpNp+n+6R4waNrCOGgHnsx6H7Sd5qpl1CbkJnPKT1hFx
	ao78+Z66cQlL5LAKbVBEh6CsX/zvdovGizez10IQhfXSlsTETwd2Ol18jh+neJizeB4ARi3Ou2w
	cXgf
X-Received: by 2002:a05:6000:4411:b0:43d:2c9:ae90 with SMTP id ffacd0b85a97d-43d595cbfe1mr16794945f8f.19.1776083637242;
        Mon, 13 Apr 2026 05:33:57 -0700 (PDT)
X-Received: by 2002:a05:6000:4411:b0:43d:2c9:ae90 with SMTP id
 ffacd0b85a97d-43d595cbfe1mr16794918f8f.19.1776083636780; Mon, 13 Apr 2026
 05:33:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413104721.203024-1-frankja@linux.ibm.com>
 <CABgObfaWO3J89sFmu3ZBPTztXcKgXPZu3FyiRcasejS=0tgJYQ@mail.gmail.com> <3eec3725-91ae-48e4-a370-9c1bdd7693a2@linux.ibm.com>
In-Reply-To: <3eec3725-91ae-48e4-a370-9c1bdd7693a2@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 13 Apr 2026 14:33:27 +0200
X-Gm-Features: AQROBzAeg5NBVyPVul8NIinRWv5vXIgL3EPHr6W2fGcFkruGU1BWpDoztdoThs4
Message-ID: <CABgObfYL-bKk7Q+cAvbigVHc8ivpdhAxSUeUSsdc5pHyoKi4FQ@mail.gmail.com>
Subject: Re: [GIT PULL 00/12] KVM: s390: Changes for 7.1
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, david@kernel.org, borntraeger@linux.ibm.com, 
	cohuck@redhat.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 2:28=E2=80=AFPM Janosch Frank <frankja@linux.ibm.co=
m> wrote:
> On 4/13/26 13:23, Paolo Bonzini wrote:
> > On Mon, Apr 13, 2026 at 12:47=E2=80=AFPM Janosch Frank <frankja@linux.i=
bm.com> wrote:
> >> There's been two conflicts because 7.0 received a number of gmap fixes=
.
> >
> > This is just nearby lines being touched, I think? No real conflict.
> It's code that's missing in next since we had a lot of changes in
> master. One is a conflict where the next list of selftests does not
> include the irq routing test that I added in kvm-s390-master-7.0-1. I.e.
> trivial.
>
> The other is _gmap_link() that's introduced in a fix but is not around
> yet for 4204067f99820 in next.

Yes, exactly - those are master and next touching nearby lines, but
there's no modify/modify conflict within a function or anything like
that.

Paolo

