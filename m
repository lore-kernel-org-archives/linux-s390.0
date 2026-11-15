Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794780298;
	b=mb6sbsgj65zWx52iYteNGxpP0pzDKB4cgqyMleh5skYoWkbqHDfrkW58CvFkds+TEepB
	 5cd8jbuFAjL2xirpL03n+sfO63byBT6HBb0CryLXbOloRDo0mJHO6hHQd19/NeoXfRD7m
	 gAIE9znn0HAUpnSwALjf0F0ArBOsAfP2Wl9FvrO5lBT4cplHPLjzsFpDuSQK0qw4yICPU
	 y8KrSGW4ZuV/YWk71ioCd2H5abehp1GLBosoREnZwXYPQ+FoW8Yt7VmJrrgwGQLZDibkV
	 /iVC2Adl/BNqDYd5SLni8YEyP8hzmR5tYGda8BWQMNNikTb+wFmz+qI+tyOzpnsXURg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794780298;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=oUYxq7sCuPQGxi589AvNCc1rPmpCBz76vLmdvKJICFs=;
	b=UsEAy5nRVwyxR/MmALXpbHZFNTvphtZDcUujjIePnDV2dSAv+/7uDcVKYjKNQKF03XPU
	 Nn1QLmDeHW5NuA5iasTc9JOQCrVLcVexE6YlDnpqLO6AoNhSiI22UW9kfH7Ou4POywfF+
	 TpOULDCd9R7aG18kUTuf6evHX5b+DjG9ejznn7E9j0UsikouqTr0qJ6LXLLaP799EeSxZ
	 Lvv2Ja7/K+vcCTGMNxWUscTySgR+Up+KtordZ4xDoNFnUE7+xTnsewUP7+r2id4nL0O7y
	 OEbfd8XAZ4N+UzXom6z8GPi1WbYwss8XyksMNkAN/SNqJ/YRl5lbNNbbZgc3LAhZwyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jgqsZvXA;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=kfYSjtFj;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jgqsZvXA;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=kfYSjtFj;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED16606A31F;
	Sun, 15 Nov 2026 22:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EED16606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jgqsZvXA;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=kfYSjtFj;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jgqsZvXA;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=kfYSjtFj
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B11851F449;
	Sun, 15 Nov 2026 22:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794780295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oUYxq7sCuPQGxi589AvNCc1rPmpCBz76vLmdvKJICFs=;
	b=jgqsZvXAQv3sa3ZKlAOT1DBrXfR53fZtdjR5VWrSHuB5csGHYm4IdRMdCXDLXwfrHFz7Nk
	x3SavfnF4aLjII/x9VKOdyQ31FSXdXLX6btCjycj4QVAv9EsS9pY3vH6gqBBcLp/uzz5DF
	S0w6w8b8/rsc7kCDFGgOimgz6K1zr8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794780295;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oUYxq7sCuPQGxi589AvNCc1rPmpCBz76vLmdvKJICFs=;
	b=kfYSjtFjQVHLxnSdfm48vtiiUnf91Rk+0jfqMhKDSMiofz2Mp+y0l41sq3BcrY1v4jgmO9
	nj9NC00Byc9jHIDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jgqsZvXA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kfYSjtFj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794780295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oUYxq7sCuPQGxi589AvNCc1rPmpCBz76vLmdvKJICFs=;
	b=jgqsZvXAQv3sa3ZKlAOT1DBrXfR53fZtdjR5VWrSHuB5csGHYm4IdRMdCXDLXwfrHFz7Nk
	x3SavfnF4aLjII/x9VKOdyQ31FSXdXLX6btCjycj4QVAv9EsS9pY3vH6gqBBcLp/uzz5DF
	S0w6w8b8/rsc7kCDFGgOimgz6K1zr8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794780295;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oUYxq7sCuPQGxi589AvNCc1rPmpCBz76vLmdvKJICFs=;
	b=kfYSjtFjQVHLxnSdfm48vtiiUnf91Rk+0jfqMhKDSMiofz2Mp+y0l41sq3BcrY1v4jgmO9
	nj9NC00Byc9jHIDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A80FF134F4;
	Sun, 15 Nov 2026 22:04:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8Vt2HoYs+mrodAAAD6G6ig
	(envelope-from <clopez@suse.de>); Sun, 15 Nov 2026 22:04:54 +0000
Message-ID: <eabeee00-1ed9-4740-b7b6-6b5be5496766@suse.de>
Date: Sun, 15 Nov 2026 23:04:54 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] KVM: don't zap secondary MMU on permission upgrade
To: "David Hildenbrand (Arm)" <david@kernel.org>, kvm@vger.kernel.org,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-riscv@lists.infradead.org, seanjc@google.com, pbonzini@redhat.com,
 akpm@linux-foundation.org, peterx@redhat.com, ljs@kernel.org,
 imbrenda@linux.ibm.com, borntraeger@linux.ibm.com, frankja@linux.ibm.com,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
References: <20261112142039.907090-2-clopez@suse.de>
 <2ff19317-8da9-4014-be04-27fc218b8eea@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>
In-Reply-To: <2ff19317-8da9-4014-be04-27fc218b8eea@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: B11851F449

On 11/13/26 8:00 PM, David Hildenbrand (Arm) wrote:
>> Series overview
>> ===============
>>
>> Patches 1-4 fix cases where change_protection() needlessly makes or
>> leaves entries read-only, so that the next write to them faults. They
>> only affect performance and can be picked up independently.
> 
> We generally don't add performance improvements without clear motivation and
> data to back it up.

Right, this is on me for not explaining the dependency better in the
cover letter and the commit messages. Patches 1-4 are required for the
new notifier flag to be correct. I'll explain this better.

> MM is currently busy with more important stuff, so best to keep your changes to
> a bare minimum.

I had not seen your "Firefighting mode" email earlier this week, sorry.
