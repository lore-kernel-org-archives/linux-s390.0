Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0665804
	for <linux-s390@vger.kernel.org>; Fri,  9 Feb 2024 08:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707466754; cv=none; b=SVx8S2nHZbwH5lnhprQusjXrQBZ0pkywORxT/+RfIXw+6239kVGC5jdRBgDEK7ghLu3ZWMy/Ko9lZ3yt50ch/pYyoxdbIRnJb9WVrrmcW14CuksC9pqFeqzfMrjuSyUtjdlKQANhgj5IQwh1YnJWJDkRZwuJHSNES7L7HxXOXDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707466754; c=relaxed/simple;
	bh=wz9ytmy5B2YrsvYQaj35Lq5p6Opt2/guURLgqp82f8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZL7hJKXsxiGdSXCk0RZ250+sVkqk1nK55x9k3sr2ZMaEX9Yy0jI4B+NXxGOJG7o1AfyRTy6o2EfgxF0dq2QUxTHOd2qmsZ/gv22/ysRZO+jyMdXyBQyyi4f8Fu2sliSmVEn7NZpXNMuTNyOCw9E+IGLI9htyG8k0HGVYEFiameo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T8HY+rHw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8HY+rHw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707466750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oFmVerAHo1noyC+XXwox3cNV5az+PMG+8xNZJn6k57Q=;
	b=T8HY+rHwu5ccZfqfHVzcV3IKhvQRI9K4OLM1ZmV9h8zf3+11G8ZqLK3xkN7eV5wJbRF5y7
	Wao4Q77W8Jb7Ae032ViRUxZMDYU4vc4W0tQgzk14rldffcGuCFOsO7+/QWWR+ssgs/Gtoi
	OAlT+HjpxtG2D6KaOKWVrJ4wOE6C2UA=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-uCsOzMQtNJScZsoRApJwsw-1; Fri, 09 Feb 2024 03:19:09 -0500
X-MC-Unique: uCsOzMQtNJScZsoRApJwsw-1
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-4c02be94035so320649e0c.0
        for <linux-s390@vger.kernel.org>; Fri, 09 Feb 2024 00:19:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707466749; x=1708071549;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oFmVerAHo1noyC+XXwox3cNV5az+PMG+8xNZJn6k57Q=;
        b=GGGKi5R1j/4uUO0UE6rxts6CewxtRi+Aph9iplO9Lg+1XwZ/G0oH3RP5/970RG/eXZ
         FFKLSFHoEfQ+85cuJMEMCg/Bhud6E/gu4MmTuCE5GbgFUwBe7DKpk5IiMA1pVsJCwMjc
         wUQWQehdGNFyYEWX7v5C3EL7jdHu76DiEyLP+YhnI5MXwzPXOwlapmipoYL4dy1czPVg
         GcoYjk6sKU7gj8oT9OwDGa9R7XmINhVX4K5Dq1MeCHihj8msvKg3UQKrZ3QGe7qalEM+
         aDCTPtrVtoXz7DOK3rHhDfKWYAThWiGodi7iQ91fYM9EbLvG9vbDkv361hZkUDXliFgh
         EXLQ==
X-Gm-Message-State: AOJu0Yxt3pQQyt8vBHf1P8DSXs27/xMhIToJYTp/TigQ/2JNN/vJ5nv6
	YClRWN/4nkS4OKBAgQgfWQmMbFzFR72CaBMuBLAw7poNO4tLW2NAwA8n8CQ5Ljh9dnyJChMrLqN
	6ds1bEDpm9oRjOMK3nvj0ljAwfu2AKRcG/ohoLATuo+SGS1eYTR3gIle7zJA=
X-Received: by 2002:a1f:66c1:0:b0:4bd:38bd:ee20 with SMTP id a184-20020a1f66c1000000b004bd38bdee20mr973894vkc.14.1707466748800;
        Fri, 09 Feb 2024 00:19:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+4Dvf+yS28ZiFiOqU7GXNanbKqb9MTZae0wqz3beZ97ZFC2RIZSt5RWU6fsGyo3THj7KhvA==
X-Received: by 2002:a1f:66c1:0:b0:4bd:38bd:ee20 with SMTP id a184-20020a1f66c1000000b004bd38bdee20mr973875vkc.14.1707466748466;
        Fri, 09 Feb 2024 00:19:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWlaKxUycvL+IAqIQjyf4bSM8DyDTG92F9BPDto+vmqkln40z4gAWu48KkFrFzsacw2RPfjKT0VoD3VcQA+xYISpS1LkNloMQNgg5kJ9ynHP4EAsezpcLT0HncDocuaEuUo5lsDZHy51NWXMvoRmRXUvAV7LTIM8YecZl4uAKatgHUGPmeSNCJ4MfIRWu7wqQ/3SJGLg7Lo6riWQAbSsnIXWE0CWS6KAwn33EcsLEU0xnWJO1Q6DmiGFlcAhQj8zp/gBUiOW3dcV29y1OErfMRwF/wkeiJAo0PZlZWRFZH6rLnuhIvyNuSZFtApbUFqCAyRcl7wT4D/wtqDYD52wWNPB00vQITZu3ZBaBzGisoUwqdwHA0Mda4Cph8MljeIu5GX+c7qIYLp+GzNee3FKmMguOlK3iF88dJHLktTM4GWGBMJF0iHeFcStghHTFPOEC9O7FuNXkRLVxazYB0q/JQgVUfo5gO2VsbPliSBrVKHma/wXbjpzUOnoFDlnX+8rjyGR1yr/JU5jl34195jzTXSvnDD
Received: from [192.168.0.9] (ip-109-43-177-145.web.vodafone.de. [109.43.177.145])
        by smtp.gmail.com with ESMTPSA id nc6-20020a0562142dc600b0068ca9ea78cbsm605199qvb.21.2024.02.09.00.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 00:19:08 -0800 (PST)
Message-ID: <74f469c3-76ee-4589-b3ec-17a8b7428950@redhat.com>
Date: Fri, 9 Feb 2024 09:19:01 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v3 4/8] migration: Support multiple
 migrations
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>
Cc: kvm@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
 Shaoqin Huang <shahuang@redhat.com>, Andrew Jones <andrew.jones@linux.dev>,
 Nico Boehr <nrb@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Eric Auger <eric.auger@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Marc Hartmayer
 <mhartmay@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, kvmarm@lists.linux.dev,
 kvm-riscv@lists.infradead.org
References: <20240209070141.421569-1-npiggin@gmail.com>
 <20240209070141.421569-5-npiggin@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240209070141.421569-5-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/02/2024 08.01, Nicholas Piggin wrote:
> Support multiple migrations by flipping dest file/socket variables to
> source after the migration is complete, ready to start again. A new
> destination is created if the test outputs the migrate line again.
> Test cases may now switch to calling migrate() one or more times.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
...
> diff --git a/scripts/arch-run.bash b/scripts/arch-run.bash
> index 3689d7c2..a914ba17 100644
> --- a/scripts/arch-run.bash
> +++ b/scripts/arch-run.bash
> @@ -129,12 +129,16 @@ run_migration ()
>   		return 77
>   	fi
>   
> +	migcmdline=$@
> +
>   	trap 'trap - TERM ; kill 0 ; exit 2' INT TERM
> -	trap 'rm -f ${migout1} ${migout_fifo1} ${migsock} ${qmp1} ${qmp2} ${fifo}' RETURN EXIT
> +	trap 'rm -f ${migout1} ${migout2} ${migout_fifo1} ${migout_fifo2} ${migsock} ${qmp1} ${qmp2} ${fifo}' RETURN EXIT
>   
>   	migsock=$(mktemp -u -t mig-helper-socket.XXXXXXXXXX)
>   	migout1=$(mktemp -t mig-helper-stdout1.XXXXXXXXXX)
>   	migout_fifo1=$(mktemp -u -t mig-helper-fifo-stdout1.XXXXXXXXXX)
> +	migout2=$(mktemp -t mig-helper-stdout2.XXXXXXXXXX)
> +	migout_fifo2=$(mktemp -u -t mig-helper-fifo-stdout2.XXXXXXXXXX)
>   	qmp1=$(mktemp -u -t mig-helper-qmp1.XXXXXXXXXX)
>   	qmp2=$(mktemp -u -t mig-helper-qmp2.XXXXXXXXXX)
>   	fifo=$(mktemp -u -t mig-helper-fifo.XXXXXXXXXX)
> @@ -142,18 +146,61 @@ run_migration ()
>   	qmpout2=/dev/null
>   
>   	mkfifo ${migout_fifo1}
> -	eval "$@" -chardev socket,id=mon1,path=${qmp1},server=on,wait=off \
> +	mkfifo ${migout_fifo2}
> +
> +	eval "$migcmdline" \
> +		-chardev socket,id=mon1,path=${qmp1},server=on,wait=off \
>   		-mon chardev=mon1,mode=control > ${migout_fifo1} &
>   	live_pid=$!
>   	cat ${migout_fifo1} | tee ${migout1} &
>   
> -	# We have to use cat to open the named FIFO, because named FIFO's, unlike
> -	# pipes, will block on open() until the other end is also opened, and that
> -	# totally breaks QEMU...
> +	# The test must prompt the user to migrate, so wait for the "migrate"
> +	# keyword
> +	while ! grep -q -i "Now migrate the VM" < ${migout1} ; do
> +		if ! ps -p ${live_pid} > /dev/null ; then
> +			echo "ERROR: Test exit before migration point." >&2
> +			qmp ${qmp1} '"quit"'> ${qmpout1} 2>/dev/null
> +			return 3
> +		fi
> +		sleep 0.1
> +	done
> +
> +	# This starts the first source QEMU in advance of the test reaching the
> +	# migration point, since we expect at least one migration. Subsequent
> +	# sources are started as the test hits migrate keywords.
> +	do_migration || return $?
> +
> +	while ps -p ${live_pid} > /dev/null ; do
> +		# Wait for EXIT or further migrations
> +		if ! grep -q -i "Now migrate the VM" < ${migout1} ; then
> +			sleep 0.1
> +		else
> +			do_migration || return $?
> +		fi
> +	done
> +
> +	wait ${live_pid}
> +	ret=$?
> +
> +	while (( $(jobs -r | wc -l) > 0 )); do
> +		sleep 0.1
> +	done
> +
> +	return $ret
> +}
> +
> +do_migration ()
> +{
> +	# We have to use cat to open the named FIFO, because named FIFO's,
> +	# unlike pipes, will block on open() until the other end is also
> +	# opened, and that totally breaks QEMU...
>   	mkfifo ${fifo}
> -	eval "$@" -chardev socket,id=mon2,path=${qmp2},server=on,wait=off \
> -		-mon chardev=mon2,mode=control -incoming unix:${migsock} < <(cat ${fifo}) &
> +	eval "$migcmdline" \
> +		-chardev socket,id=mon2,path=${qmp2},server=on,wait=off \
> +		-mon chardev=mon2,mode=control -incoming unix:${migsock} \
> +		< <(cat ${fifo}) > ${migout_fifo2} &
>   	incoming_pid=$!
> +	cat ${migout_fifo2} | tee ${migout2} &
>   
>   	# The test must prompt the user to migrate, so wait for the "migrate" keyword
>   	while ! grep -q -i "Now migrate the VM" < ${migout1} ; do

So the old check for the "migrate" keyword is also still around? Why do we 
need to wait on two spots for the "Now mirgrate..." string now?

  Thomas


> @@ -164,7 +211,7 @@ run_migration ()
>   			qmp ${qmp2} '"quit"'> ${qmpout2} 2>/dev/null
>   			return 3
>   		fi
> -		sleep 1
> +		sleep 0.1
>   	done
>   
>   	# Wait until the destination has created the incoming and qmp sockets
> @@ -176,7 +223,7 @@ run_migration ()
>   	# Wait for the migration to complete
>   	migstatus=`qmp ${qmp1} '"query-migrate"' | grep return`
>   	while ! grep -q '"completed"' <<<"$migstatus" ; do
> -		sleep 1
> +		sleep 0.1
>   		if ! migstatus=`qmp ${qmp1} '"query-migrate"'`; then
>   			echo "ERROR: Querying migration state failed." >&2
>   			echo > ${fifo}
> @@ -192,14 +239,34 @@ run_migration ()
>   			return 2
>   		fi
>   	done
> +
>   	qmp ${qmp1} '"quit"'> ${qmpout1} 2>/dev/null
> +
> +	# keypress to dst so getchar completes and test continues
>   	echo > ${fifo}
> -	wait $incoming_pid
> +	rm ${fifo}
> +
> +	# Ensure the incoming socket is removed, ready for next destination
> +	if [ -S ${migsock} ] ; then
> +		echo "ERROR: Incoming migration socket not removed after migration." >& 2
> +		qmp ${qmp2} '"quit"'> ${qmpout2} 2>/dev/null
> +		return 2
> +	fi
> +
> +	wait ${live_pid}
>   	ret=$?
>   
> -	while (( $(jobs -r | wc -l) > 0 )); do
> -		sleep 0.5
> -	done
> +	# Now flip the variables because dest becomes source
> +	live_pid=${incoming_pid}
> +	tmp=${migout1}
> +	migout1=${migout2}
> +	migout2=${tmp}
> +	tmp=${migout_fifo1}
> +	migout_fifo1=${migout_fifo2}
> +	migout_fifo2=${tmp}
> +	tmp=${qmp1}
> +	qmp1=${qmp2}
> +	qmp2=${tmp}
>   
>   	return $ret
>   }

