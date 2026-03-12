Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A2634752B
	for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2026 06:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773296197; cv=none; b=S0FnlT7Cn4rlHZ4ZtfXQVrO+Cwa2qqtA5UKmkw+Vh+7HZKXlVhzEjN86VMRHcqUPTeJWH12PjDo+ctCeP3X9tRsSNJ3N1GkFfLOpAIMtl6vuV4NsJV0sVD6aqjEdgUz4r14PT/btUKwZKU8sa57Kp0WUzs5dzc9pma2xfdZkBjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773296197; c=relaxed/simple;
	bh=AHPgpQXNpmocpftwSDROOrgKtU/VXiRe/PzkSgRw7+E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i5h/hXIfLnkfrgP2xaCSdFJz+0h6rJW1UIb0ZGX8NWp3wRuogMKrewS95+U84CM6yDGqwGLSS9zwIANcbQlubS91G75eRVpodcow0mhFAVgWULZmvvGI6K7N2iDFaPoWIt7Vd2ufyMJH6gsFbnM+0GwBFn7DyqbsWxdUGTYii4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u7ZhM/0x; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u7ZhM/0x"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdff07d8f4so1039012eec.1
        for <linux-s390@vger.kernel.org>; Wed, 11 Mar 2026 23:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773296195; x=1773900995; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SBDz1m5N4ziATwBlDRma/nMU8Fwj8JUl1F3v6VB29uA=;
        b=u7ZhM/0x9mh0q2lDmDYJR9wNFf9Kfoh1XpDvDBlKS3w2Wuxr+OpcA+1eDcXiv38icC
         SS741s2ot0ZPyIixW/QCJeeRYnPCAttSVd4PD5axDEbQDkNmZSomWbydC1o6du8S/BYC
         dCe2fwz03dcNTCokFcJ0Lt/V00cAJDB7j+U/a2p26HsVFYjvEcbjUOHliFzxpueQ1utV
         9mLU0cJAzqctZmbUkiVMyTExnhlJLP0qzd5qKOWG3tP3f/6eIzxHq7QMvA5mNL5BLCJY
         MjdjKwe1H0QwN0UgGNstbg2x2/5gOsOkOUPYdlIFOddx065g3tv+v5yuDsknHiVFpbYU
         ey6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773296195; x=1773900995;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SBDz1m5N4ziATwBlDRma/nMU8Fwj8JUl1F3v6VB29uA=;
        b=BCkupygKkfJ75R2Ad7thMRt1QVg4NrBrVmclQzGb1r/mwUmfCzPOzw8LDIWIw8k+IH
         NmdFcQ1cNUS0oK712P4n2VnHrIji7av3IiqvXJ/azzTGDjZ+4X4AaP7dmvtqBp04PYQf
         IYDFErazrj4o9xDa073GUiVzfgsL24v8h/s+yELqr7+qt3QVz1kuOwOXvXFRMt7N9sUe
         c2shGCxAk8dHIiIhVWXUc3P5dr9qHsDADTgCs67huwqjhnJdmXtaUegCo46AwWhrPEGa
         cULzxDkN/GXT3X2HhGYqRitbhyirymlewD/0yDtp2X773TVkMRtiY7f5RZG27k3jfZLV
         78cA==
X-Forwarded-Encrypted: i=1; AJvYcCWMGF0WQxWHkiA125U951AytMXnk6xJiCeYFpxRdUPHgSM5X1sCAJ14PgvCbqDGXYHFCkmqKJKZFEnL@vger.kernel.org
X-Gm-Message-State: AOJu0YxeLmemIIIeT+iMWIl6BEbC0kEuZC/72SrccZ/V8VvFPsAxwW2s
	UVGZrrF6eO39ATQ8aiSy/npt1uTF1G0SIU8FUJ0WHJqswiOMAm719AEwdmt8FTFEISCKHZAXdUS
	7ChG1Jtn0tw==
X-Received: from dys13.prod.google.com ([2002:a05:693c:800d:b0:2be:798b:cb2f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:310b:b0:2b7:da62:a5f9
 with SMTP id 5a478bee46e88-2be8a57b407mr2086093eec.18.1773296195273; Wed, 11
 Mar 2026 23:16:35 -0700 (PDT)
Date: Wed, 11 Mar 2026 23:16:28 -0700
In-Reply-To: <20260312061628.1593105-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260312031928.1494864-1-irogers@google.com> <20260312061628.1593105-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260312061628.1593105-3-irogers@google.com>
Subject: [PATCH v2 2/2] perf evsel: Don't configure framepointer callchains on s390
From: Ian Rogers <irogers@google.com>
To: tmricht@linux.ibm.com
Cc: irogers@google.com, acme@kernel.org, agordeev@linux.ibm.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-s390@vger.kernel.org, namhyung@kernel.org, sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Frame pointer callchains are not supported on s390. Ignore the option
and print a warning.

Signed-off-by: Ian Rogers <irogers@google.com>
---
v2: Only disable user callchains as AI is telling me native "kernel"
    callchains are supported on s390.
---
 tools/perf/util/evsel.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index bd14d9bbc91f..fa21b48cba86 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1076,6 +1076,12 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
 		attr->exclude_callchain_user = 1;
 	}
 
+	if (EM_HOST == EM_S390 && (evsel->core.attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
+	    !evsel->core.attr.exclude_callchain_user) {
+		pr_warning("Excluding user callchains that are not supported on s390. Try '--call-graph dwarf'\n");
+		evsel->core.attr.exclude_callchain_user = 1;
+	}
+
 	if (param->defer && !attr->exclude_callchain_user)
 		attr->defer_callchain = 1;
 }
-- 
2.53.0.851.ga537e3e6e9-goog

