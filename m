Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140D82263A
	for <linux-s390@vger.kernel.org>; Tue, 18 Jun 2024 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724979; cv=none; b=T81lFxNkV2OJj0AL9bTqaGqCCX4+cr4Ki70TfLi5h3RK5rUK5/Mhd0LNkpzlUdcPZkhBVcIZXpXCxgnaSAKVLn/HH+OmzVrezmvu4S9B0ZppTIgHHfI0cYqFFhco8zvDKhQS9fVooe5+jvtD5O06hipSOtHBKQWWoLXq2l24238=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724979; c=relaxed/simple;
	bh=5RGeJPOFaWHdjpCL2phNpFb4SArUUUeonhkd+IsWbC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VApVp92DW72sCo3rocDppWvafTfzb1QRPlJfDnsZuRTQ+3ZQFJsTNEB2zVR7vcGGdE0inIel5RCN5NgmZtnCuSIME6AmkY8g1Q0t/U1FzqFlnDnunQwEcZPdnPr1nbVhN5kwaxFZ701GO86GWFSvWu/629NZo6ROKu9aLjZJALE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ysXS1H4f; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ysXS1H4f"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6f9b4d69f53so2989861a34.0
        for <linux-s390@vger.kernel.org>; Tue, 18 Jun 2024 08:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718724977; x=1719329777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RGeJPOFaWHdjpCL2phNpFb4SArUUUeonhkd+IsWbC4=;
        b=ysXS1H4fS2mPV03Y4L/m84FKCjlkHSxi4xOu32dnqb6LzOwsyaraZoWoQH+LcpDk1H
         cFgLindy9f2RhCTqS2qdoZsnPhxjDYvAYZAuddd4mGhwuKseFVr+T63p/7jRFd9y+8Cu
         iq0nWFCXflnt8DFMsx1/RMCPABIQxCQpdHxEGONq+sFpQwMV16Ue7TY3DTYPNXp/mhaL
         MO9tdYbrl+a/D/gLdejAg8ugwKJEf4tbZHMNevcmsVyEtI1oi6TnGsm6KCITtEcIjsmo
         X9j0hF2G1+SGmpdKf/cBeoxvm0rOSp5qNU5/nl/oIjxpF4+GluSqPb5OiFNDRVFGRs8d
         BLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718724977; x=1719329777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5RGeJPOFaWHdjpCL2phNpFb4SArUUUeonhkd+IsWbC4=;
        b=fig32QOcfqXshAGWqBzgYl228sFrBMBHNHKPOeDHGk0zNvYe409oVZsyoeJCeVLjns
         VuCC9ZnazCd1fqZp63agsg4ZP9cZoUmOrTV4lEZ1nZsYttC1f8T7fGLVTvHZFwa7kKLL
         UAYz/dTflu2AqFmB66M5X07qK0hDYZ5fpO+/qKbNaFEdHx6NPlrDdvxUFSgonDrYjN6o
         cM8M+HyanMShmBle+sVdBxvTFdK70MVCCYjIJ3QNTZH8KKLP6K4EKs4pLbTuukZv3aZP
         CC6XIAihZ1gCcIk0iOjnbD6PTzooCgbYkeRFzciRagskzHYvHQDMTmF/K4DQr0TXZyL8
         98PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfkTFfBgpStCfZSEcbflyFohY/hgYKYlc0njLpnwNhg0ND1QbvyK/Zhy97q8wYo3cFZoQoeTzmcHjzkcWNzAyrT6+mc5BtzMCtAg==
X-Gm-Message-State: AOJu0Yyp9Kpa0717Fs9k5Z61seK71JwZfADCIuE+zZdyg0nSjGuRxHUa
	7C0qjUpb+E7/c6O+P2frrikP14zmERQUw8CtZokDgymhO8fBGJAUGb8wo5swgiPq+dFx6P5MbrK
	LO+OmgTdEJkK6WYOaZ3jQot4aNC1KAKgHFzqx
X-Google-Smtp-Source: AGHT+IEspShaRu1ToIazyKYK7a+yojtYmsB71BOjBBtI4HtP9AWTraCEUo7NTIwtb9GkxSM1Qq0A95f/tFWqAqFyrLk=
X-Received: by 2002:a9d:6510:0:b0:6fd:6240:9dba with SMTP id
 46e09a7af769-70074ebf134mr77156a34.16.1718724976930; Tue, 18 Jun 2024
 08:36:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613153924.961511-1-iii@linux.ibm.com> <20240613153924.961511-10-iii@linux.ibm.com>
In-Reply-To: <20240613153924.961511-10-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 18 Jun 2024 17:35:36 +0200
Message-ID: <CAG_fn=VT5u6fn6eaqzdB4bDZ+aw0kKBta7_Ff2Thn813RG6EVQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/35] kmsan: Expose kmsan_get_metadata()
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Pekka Enberg <penberg@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Vasily Gorbik <gor@linux.ibm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 5:39=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> Each s390 CPU has lowcore pages associated with it. Each CPU sees its
> own lowcore at virtual address 0 through a hardware mechanism called
> prefixing. Additionally, all lowcores are mapped to non-0 virtual
> addresses stored in the lowcore_ptr[] array.
>
> When lowcore is accessed through virtual address 0, one needs to
> resolve metadata for lowcore_ptr[raw_smp_processor_id()].
>
> Expose kmsan_get_metadata() to make it possible to do this from the
> arch code.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
