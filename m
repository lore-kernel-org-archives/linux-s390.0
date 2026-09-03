Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876D03E3159
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 19:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788462837; cv=pass; b=iA9WrD06LQsS9H3Qptz00EeCW0t01YpCZC3A++NWg53FZJNzaGwnq3UUAoTps7hkbWkJ+d74VBPqr4M8/Sy3PZXhhRd+/RlfR5s8f5cSzsbWWcGjz1974UzmEmXtZZdJJQKlLjVW9Si74gMLdkYDIPuzrPsO7vPq9vaQBeOObcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788462837; c=relaxed/simple;
	bh=LQ5MmxlCmAkfvdFvXrKZhXx7Fex14wUm+MceK68pFDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CvDg/iQr5oMKJtfPl7OqDGDaQ4J/4WPoSJgLw+S2f5oR2IDC4G6MABLkaeih6JWz5/4uOPQUb8QCG9EOQMQZCo+jdLqFS/ifMV2U17pYxWgRbQ1WFJSHiHN9MiOTKhSlt5BbdTyyMnt1oezQ92O92LFhrH3fxjzy+oGghDxwcLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cwdSFHGU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Thmv5YVP; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cwdSFHGU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Thmv5YVP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788462825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ftgzyujbx9F68uHjOCU1/tri9c4N8S6xaXNJtzq3Flg=;
	b=cwdSFHGUB5A4gw2DrXzNUj8QNSk5NRzKQXNlNBKl5gcyW8AbIIsQ3VXAg8cy9jZEkGboev
	VknJLN50cEM5kARqRg1jo4r1mWl/2NBSuDGwQxOClWnRO3NdwiFK8kvJm5GYS7U6Pqm3C6
	7FyygcPNYD+HUEUocketHZue9RCBi+g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-T3yYglbmMACTQ8kbWZrHiA-1; Thu, 03 Sep 2026 15:13:43 -0400
X-MC-Unique: T3yYglbmMACTQ8kbWZrHiA-1
X-Mimecast-MFC-AGG-ID: T3yYglbmMACTQ8kbWZrHiA_1788462822
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-484357599a4so110272f8f.3
        for <linux-s390@vger.kernel.org>; Thu, 03 Sep 2026 12:13:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788462822; cv=none;
        d=google.com; s=arc-20260327;
        b=pG7j9Cxa496wLK5b/KkV6GzXVExzYYA46mqqYoKLoD962+BtXLZiQbDW4NHZxkvesh
         I4L+HZfHgozW+zQ692vpYSwyJhAZQWHHi6jtUV+ky98EEXz9rbNPf4w22UjBPk14svFv
         5A7NLdAk8iwwKSKmwpbhcXyj7kFaVpeqIjLdBiXES7fqtCeM71vUlPOofSCGfuiSx6F4
         cOTF5tc0+AwYfYuvHXWpP/uPP20o+dMCvtU3lXT/lwej4WKxT7gEj39saJx8JLyoXRbW
         ua9vJgT0KZijjowag7woyMq+ZAyh0CxAyft5jaAWQlqWEaXeAAJuHQTbAs24Rc7uZcsy
         EAEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ftgzyujbx9F68uHjOCU1/tri9c4N8S6xaXNJtzq3Flg=;
        fh=4UqSYNFl57/BLfhK1UhmfLI7N4DYwjWb0ymWvE34lcY=;
        b=TAZHJLXj7yOyHDj/+E8RNvoDGmxub4FJm4oNF9tmTArJBPRm44l8iEofV1NashEX9I
         6p/fI6IqO13j4b8erWUtd5w18TA6BzXb24UmvnWOqlwEYlHaVsqgqmBaLN2YYpwr3MEl
         8YJ1JD+EsZZTDZkHWWCherqJHSyYrsFPKCPEK7qQvKc5FQUcVQh+50GXEmIzChKw+5DH
         wwSNjRLerRkzsarnh6VTniGg2MlsohD1H+rRWy4IT6O5KzhpfKof5JEwTBom1hkqdJQk
         01rK+JT4qPQGi6n+w+Hjx+B2jnRre2eaFG/479Fp+EqzVYENe+xWSn/NLMMQxLM4pfSj
         nw6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788462822; x=1789067622; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ftgzyujbx9F68uHjOCU1/tri9c4N8S6xaXNJtzq3Flg=;
        b=Thmv5YVPhjH2NQjhg3KY4IemgkxPsePHBJBeBi7rTC106HNgb5heT7m9wpoAoJjOuG
         qwW88eJsTnYYau4nRA2i53lzw1EKdCBb1nqmVwg6JMKmXDhJQz4R142OshQ2p980YDyt
         Cb6JL1xwSgWjIQYtHCK0EYGs+e6JSWTtjiDvI1Vl0+a3wBzYaOGNeEBPq0B4Xl4zvEzD
         +rDksf5ytzrnhAdZp2QRMLbYsDhnb509GcMbJGJc0S0Ilroqo8x9DKwsgJ8lRPzoL0ai
         MfStRG+qKVP3yN5Z8MhJVNiIOCy11tPpPerRmiMZC5Jp8JCNss/fdOmvcgArevWbQF82
         W6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788462822; x=1789067622;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ftgzyujbx9F68uHjOCU1/tri9c4N8S6xaXNJtzq3Flg=;
        b=ZMS/H5OVAJq3B6ALUZs6h5cB+wf8r1vbI3kYSmviNa8yc0BxpkCWQW8MDhTfZGJNgq
         C6a7cdAihvpNyBF+NC66TzC4u9OLtTKK615HmN3hr/W9UZqPIGsUWvlQzplks13DzFbJ
         oFDUaHwaJk6Y1c/F6XKIZi2/kqO9f66n9QWayFXNC11e5FUm1tZ/MqXJYql53NqNsi4+
         CeRiqjuq3R6DqdB4hTupRxlAyRmOubd6SIQIb8Op509/CBdutQehPvwo0EjrSPQBqrHL
         BFUcdxDLuMenR/MIX2J0nLLtBa5rlmwB3ZmfMgETyw2VpJUxCWxeTz79owi4GTh7hMDm
         IO3w==
X-Forwarded-Encrypted: i=1; AKwUvBwcPOFN+yMI7LZPZjR2bcGaJld+UOnYNwhiVwJaUvQjT3wSZLVYlM2jiPcoNtHr1uCv7hoyYM3mudbb@vger.kernel.org
X-Gm-Message-State: AFuF++mMmGDzqg1sTOk93ePnpT4L4wB5RjeBSPuV2K3MX2WTYPw68lBd
	a/d1kTBGG7cPRkBoXEU0R8lgKdBTicZMffmb14CrCQT8gi6hehAgBS9S5ECC5k1BBLWkG9L50fm
	dfBIhefI6v41OZFjkOXHdJ+WThYR5NnGu5PuIp+hnm4p0wA5+Vqlg2I1fzKkg6l23Y6b+7ot9Ak
	OwcNlfmao19JLLKlvN+cIYTT5Br+9erHfR4LN9Nw==
X-Gm-Gg: AYBFou2W9IAclY0txJV+z0Lmyq24jhFDE6AN6NO36oDXtKvNYqpO+nbBg6hDofo2loK
	k1DpJ9BGrdEyWajuAz5CiAZwXMPxkfrf+bQgIjlF7Jg37mpgOeDsUjC9t9Cv6eVXTB36NdlU9wH
	ehFRfhND3KfJBf4wJxpJEFbY3ahHnTzX+Iy49bTR5VBqAPZ9a30Eo6ByoRLT4EJwK9oqYb45sg6
	fbGodslekWJxyht2gVgGdUI+qF+k50YbOzGPJ4yN93oRByZf/jYPKCBZXyQ
X-Received: by 2002:a05:6000:2084:b0:482:f0ee:1390 with SMTP id ffacd0b85a97d-48587289c5bmr2438688f8f.22.1788462822428;
        Thu, 03 Sep 2026 12:13:42 -0700 (PDT)
X-Received: by 2002:a05:6000:2084:b0:482:f0ee:1390 with SMTP id
 ffacd0b85a97d-48587289c5bmr2438609f8f.22.1788462821985; Thu, 03 Sep 2026
 12:13:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831144802.834315-1-seiden@linux.ibm.com> <20260831144802.834315-3-seiden@linux.ibm.com>
 <apdweRfqt4dTxcU9@google.com> <20260902075028.231001-D-seiden@linux.ibm.com>
 <aphLXQL1H2zYZgTi@google.com> <20260903114241.33034-C-seiden@linux.ibm.com>
 <apmEi1NmOUvmUBFP@google.com> <apmFClPZ2WcDINmT@google.com>
 <apmIGgMEN8w-kQAm@google.com> <19d4feb1-d703-4c62-8622-a6d5e9d6394c@redhat.com>
 <apmYPMMPCNzK9ZEA@google.com>
In-Reply-To: <apmYPMMPCNzK9ZEA@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 3 Sep 2026 21:13:28 +0200
X-Gm-Features: AcwNN1VM-0Sta_usKYpoIMa4PlVb-9vByCd46nQw98qW4Zt-Pg_0xPWbP_VjwBM
Message-ID: <CABgObfZL-qNSaNkNZDj0Kk41zw6UZ30vkSxc6T8wb-pOKab9Wg@mail.gmail.com>
Subject: Re: [PATCH v7 02/23] KVM: Make device name configurable
To: Sean Christopherson <seanjc@google.com>
Cc: Steffen Eiden <seiden@linux.ibm.com>, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
	Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>, 
	Gautam Gala <ggala@linux.ibm.com>, Hariharan Mari <hari55@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>, 
	Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>, Oliver Upton <oupton@kernel.org>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 5:54=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Thu, Sep 03, 2026, Paolo Bonzini wrote:
> > On 9/3/26 16:45, Sean Christopherson wrote:
> > > > > Actually, thinking about this more, what I've proposed here, plus=
 the pattern of
> > > > > #define-ing macros in arch-specific kvm_host.h files, should suff=
ice.  For things
> > > > > like __KVM_HAVE_ARCH_VM_FREE, it absolutely makes sense to #defin=
e the macro in
> > > > > kvm_host.h since it's very directly tied to an arch callback.  Wh=
ereas with KVM_MIO
> > > > > and KVM_ASYNC_PF, because they enable compilation of C files, it =
makes sense to
> > > > > define them in Makefiles.
> > Ugh, defining CONFIG symbols in Makefiles sucks.
>
> Sure, but IMO wrapping entire files in an #ifdef that comes from an arch =
header
> sucks more.  And technically, these aren't CONFIG symbols.

True it wouldn't be -DCONFIG_ (fortunately). But even if technically
correct is the best kind of correct...

> > I don't want KVM to be the. one that does things differently *once more=
*.
>
> Too late :-D
>
> arch/arm64/kvm/hyp/nvhe/Makefile:ccflags-y :=3D -D__KVM_NVHE_HYPERVISOR__=
 -D__DISABLE_EXPORTS -D__DISABLE_TRACE_MMIO__
> arch/arm64/kvm/hyp/vhe/Makefile:ccflags-y :=3D -D__KVM_VHE_HYPERVISOR__

Sure, VHE/nVHE is fair game because the nVHE case is in the same boat
as vDSO, arch/*/boot, and so on.

Looking at a grep for (cflags|CFLAGS).*\-D most are -DDEBUG,
-DDISABLE_BRANCH_PROFILING, -DDEFAULT_SYMBOL_NAMESPACE, etc. and in
most cases they seem like a bad idea. Don't do it for KVM please;
requiring -D for all architectures and for random pieces of config,
when you can put it in asm/kvm_host.h, is just as bad if not worse.

Paolo

> And I think there's value in deliberately being different, because CONFIG=
s are
> kernel-wide things, whereas the thingies in question are KVM-local macros=
.  I.e.
> IMO, having the behavior stand out is a good thing.
>
> > I'd prefer to stub out the contents of the .c files instead.
>

