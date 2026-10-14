Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D119E54CF59
	for <linux-s390@vger.kernel.org>; Wed, 14 Oct 2026 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791994936; cv=none; b=lHpwxBNX1Q2hJywbn/izARnNuLGCK05NNQpaJe7T5D32LPbqwFfVIBfpAsjA9odzLs3jTi5U995EBpojbMZzKTtZAA8Wdksb4OXANsXPWpkYVAwQR2O69BBMqzJCkQMKjiMau77sBU0+YvXpkt8YjSNhFDFyqSOjAhr0Se59Jdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791994936; c=relaxed/simple;
	bh=I908KxkVSA8JjSDsvFdsWwPzP3a4/hSDI3mROpfddIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SdW5DYblEAo/oWmlpiUin27rg4qLYHT7JujO0rRIYZjiDtA+bbW6BXwBYL/hdaySTUt2dCWnlHel/jethJGRLTgloTXu/cbJdeVQ07UC6ukNzPzUO2iXYQORq0d7TnD0lkqRtEZspIl2MQqKaXqBhXJgnIo4EaWkO7CRgHgukcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N1Dc/NWc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N1Dc/NWc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791994928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+Rz50mbCkbo2xu+BCfFoLFWsjTohIeRcqAnY5S/7Fuk=;
	b=N1Dc/NWc//smaeTMAfRKuu5RfBLeIjorTH32jLUlGpH8OLn0U8VNGv3iTKfkLYlglwh+II
	VQ4PF+koC283dwlWNj6r6+w+U8kid8b/zbXRDHGTbn9eMFpLIpGPGaNvbKyc2M92y7ycDY
	YxsyPYGoSqONoQ6MV9zu5r+lcELQ6tM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-tlFTr15zMHW2ZM0c4FD04w-1; Wed,
 14 Oct 2026 16:21:57 +0000
X-MC-Unique: tlFTr15zMHW2ZM0c4FD04w-1
X-Mimecast-MFC-AGG-ID: tlFTr15zMHW2ZM0c4FD04w_1791994913
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 662721800847;
	Wed, 14 Oct 2026 16:21:52 +0000 (UTC)
Received: from [100.90.56.12] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0AA7F1800480;
	Wed, 14 Oct 2026 16:21:43 +0000 (UTC)
Message-ID: <f2c774ab-8b19-4041-81dc-fe6368ba4d44@redhat.com>
Date: Wed, 14 Oct 2026 18:21:41 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 02/24] KVM: Move architecture capability Kconfigs to
 header defines
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Friedrich Welter
 <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
 Gautam Gala <ggala@linux.ibm.com>, Hariharan Mari <hari55@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>,
 Joey Gouly <joey.gouly@arm.com>, Marc Zyngier <maz@kernel.org>,
 Nico Boehr <nrb@linux.ibm.com>,
 Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
 Oliver Upton <oupton@kernel.org>, Sean Christopherson <seanjc@google.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
 Zenghui Yu <yuzenghui@huawei.com>
References: <20260930173441.66762-3-seiden@linux.ibm.com>
 <20261013121343.1997112-1-seiden@linux.ibm.com>
 <20261013122020.715112-B-seiden@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20261013122020.715112-B-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 10/13/26 14:20, Steffen Eiden wrote:
> On Tue, Oct 13, 2026 at 02:13:43PM +0200, Steffen Eiden wrote:
>> With s390 hosting multiple independent KVM implementations within the
>> same kernel build (native s390 KVM and arm64 on s390), global Kconfig
>> selections force both implementations to inherit options that only apply
>> to one of them.
>>
>> Replace global Kconfig options which only apply to one KVM
>> implementation with architecture-specific opt-in defines in the
>> respective <asm/kvm_host.h>. Only remove Kconfig symbols that would be
>> different on both s390 KVM implementations
>>
>>    - __KVM_HAVE_INVALID_WAKEUPS		(formerly HAVE_KVM_INVALID_WAKEUPS)
>>    - __KVM_HAVE_MSI			(formerly HAVE_KVM_MSI)
>>    - __KVM_HAVE_NO_POLL			(formerly HAVE_KVM_NO_POLL)
>>    - __KVM_HAVE_READONLY_MEM		(formerly HAVE_KVM_READONLY_MEM)
>>    - __KVM_HAVE_VCPU_RUN_PID_CHANGE	(formerly HAVE_KVM_VCPU_RUN_PID_CHANGE)
>>
>> This allows each architecture and guest implementation to configure its
>> supported capabilities independently in its kvm_host header and eliminates
>> adding unnecessary fallback stubs across different KVM targets.
>>
>> Acked-by: Hendrik Brueckner <brueckner@linux.ibm.com>
>> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
>> ---
>>
>> Sending this patch alone. All others are OK or already picked.
>>
>> Changes for v10:
>>    - Use __KVM_HAVE_ as prefix
>>    - Clarify that this patch touches only selected Kconfig options and
>>      not all.
> 
> Paolo,
> 
> Sorry, I somehow managed to not CC you, doing that now.

Applied to kvm/next, thanks.

Paolo

> FWIW:
> Original patch v10:
> https://lore.kernel.org/all/20261013121343.1997112-1-seiden@linux.ibm.com/
> 
> 	Steffen

