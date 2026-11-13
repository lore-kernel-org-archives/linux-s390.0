Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577730;
	b=ibsD7NskJI93i3bCD2/GGYHKTbyB92e781PtdFPRX2zO0VvBHDf01JfyZShdjbvuZSR8
	 FMKTi/J+/VzwXuZk6E+2BzxsIAW2RBNTj2AUa1qvSTPx6TicrnrNdu9sNEqrbxzDPXiM/
	 Thl4qX2HcjQ76XqclH7lI1pbjUddfjUAk0IlDWYnNRXOBvYPYkcndqThtaDkf0Uu7GM/x
	 iJALxXDfob7aPtPUqeK8f26fncMjVQNzvwZ/tFwb18lzmWmsUGMWLNc8/A4Fg7zefZKaM
	 8NXPZfXiykeHnHeLoxN5lh5bNAiapUWl7GChDDe7v2wNXTKEJupWGomaIrd/BUcjZzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=owQijkkt4PGB+i0XYnWR09SeC4OwCpHMumuAGD1MVVI=;
	b=J/J0pl+XN4kViScHaOqGVeKlMmP+0LjW7CMeJOlRgqXN+oazegbc9Pi1ZcQB5FQi9RBB
	 7/YMCZfCEOFT8TLccum+8BB6b/jbzPmGCAtKqc0eIjFdq3I4jv7I01uSfh4pqm+H4mrW8
	 9y4yfbic7weSysdEq1CxebQ/Rq+vqkrivyHh7X1ac2gtXI8XlS5oQxfDTnhRsqUZI2HJd
	 /x+dPApMJCuKkQEOiGY48ASjnFA80mgpS8mo6LPmb11aPAfHLLDf5p/YzJrUKPQyLI6be
	 waJEn6Z9JiMWiB59qTTmuGAI75W3LYChBk8ziBpdEg2CmmCeS/E623LK2EqcnGUK4fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=B9aYRATs;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47047606A880
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 13:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47047606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=B9aYRATs
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8b5d8de9619so1251803b3a.0
        for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 05:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577730; x=1795182530; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=owQijkkt4PGB+i0XYnWR09SeC4OwCpHMumuAGD1MVVI=;
        b=B9aYRATsr6AjwFdmMFe+QqETDSJS8V+FIDOZb9ABXD+4Ee9sHeSAzpr6Wg0xnPQ22Y
         +grnUbNyqtaKo5Z0+NPmgalzhswXvyqpVeI131Yd4l33OSiYSlKof50xrlkIYYqR1CFJ
         BetSPA0vNGW4IDtCx6b2Mz8hgSw+WFvtJ4B29zYNmHN9blYTy9sA9LGiaf16t/ervrup
         wWgRimuEyWjsB1hXFpbNyAC7KW6GIBY9PffjMGYdhWRTPB97u5PnZBx2MQP5zjzw8uU6
         SgOPzW096mP6trUDFYAAiFkbHFe240dNEdcIfNLuouDdnFKEguPinZsPv0aws5hDOnXC
         27VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577730; x=1795182530;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=owQijkkt4PGB+i0XYnWR09SeC4OwCpHMumuAGD1MVVI=;
        b=KrBsqNnXR325a1BZWbUh3GwjRyKZi47HaJTtfdqrr7eb+/ejxN0GVv6y+iEZYtaaN7
         A7i3d49yYkNU70cUORSxfLZVE09BRR2pmsq1rTA0Ztj+e/gHMNFZw3yrCHWG25UoynGJ
         10bwK+UR+IlwlK81yc7V2Bsjrq6Ze656/MQv3NpKIGxVNEGFvSwooVgJUn84ccci98T0
         sTKKTry4DKmRegstxV+UdVEbn9J6bDUvMZFcp3fPqHh1aL+ulhlOnf1tkd/vUS/knCVY
         KcUsBGfYudWT/06LjcCbSug0nxEssVC7LuZaQfjuYkvFr531zzfbnHfkNtkYDDuVTjE9
         82QQ==
X-Forwarded-Encrypted: i=1; AL+hErHtj91CtO4Tf5bF1SkloiuZAySX1/0sgMyWKYEHGBcuAzfHWnWfy2pjz6sEFzPEH/XFWIEE9PW5lsJZ@vger.kernel.org
X-Gm-Message-State: APuU4Z8vJa8ZiwkkiclZSZhMZLSUooA+uVYgMocxtvdLySoG9OvdRP3b
	ImPolzQFR2XOEWqxYAuX0PIMJtTjUmM1ZQWRlFu9roOzDIzDKYe6bU9SCC4LrV8xocxe3dFNBup
	cJAK48g==
X-Received: from pfblt8.prod.google.com ([2002:a05:6a00:7448:b0:8a2:7343:1d03])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:807:b0:8a0:58c3:8ceb
 with SMTP id d2e1a72fcca58-8beb753d1b7mr2666112b3a.45.1794577729376; Fri, 13
 Nov 2026 05:48:49 -0800 (PST)
Date: Fri, 13 Nov 2026 05:46:30 -0800
In-Reply-To: <20261020175818.375700-1-borntraeger@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261020175818.375700-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441818685.80121.18041691595252974773.b4-ty@b4>
Subject: Re: [PATCH v2 0/2] Fix error handling for async_pf
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, 
	Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Tue, 20 Oct 2026 19:58:16 +0200, Christian Borntraeger wrote:
> Return mapping errors also for async_pf cases. Otherwise guests
> will loop forever. Nothing critical just missing error handling.
> 
> v1->v2:
> - !npages instead of npages == 0 (Sean)
> - new block comment (Sean)
> - fix testcase to build with 7.3 and 7.4-rc
> 
> [...]

Applied to kvm-x86 generic, thanks!

[1/2] KVM: Set up async page faults only for faults that need to wait
      https://github.com/kvm-x86/linux/commit/9e03117114b6
[2/2] KVM: selftests: Test that KVM_RUN fails for unresolvable host faults
      https://github.com/kvm-x86/linux/commit/05bb06acb180

--
https://github.com/kvm-x86/linux/tree/next
