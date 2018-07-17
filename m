Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH v13 13/18] x86/tsc: calibrate tsc only once
References: <20180712000419.5165-1-pasha.tatashin@oracle.com>
 <20180712000419.5165-14-pasha.tatashin@oracle.com>
 <928b8490-89d2-46a3-8596-16751bcd12db@cn.fujitsu.com>
 <CAGM2reb-MwiT8qoiSkXCjAAM46JOYL9BP+U3q7PMTcxp9EiK7w@mail.gmail.com>
 <01812492-b88b-4436-570b-ef776eaafc6a@cn.fujitsu.com>
 <CAGM2reaU1GouLvUfW_dbs7gFiYCMX=X+Vag2RnuofmmgS4_TdA@mail.gmail.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <4f6b295d-c88b-2204-0557-ae85ed443a31@cn.fujitsu.com>
Date: Tue, 17 Jul 2018 16:59:58 +0800
MIME-Version: 1.0
In-Reply-To: <CAGM2reaU1GouLvUfW_dbs7gFiYCMX=X+Vag2RnuofmmgS4_TdA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, schwidefsky@de.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com
List-ID: <linux-s390.vger.kernel.org>



At 07/16/2018 09:35 PM, Pavel Tatashin wrote:
[...]
> v13 has xen patches, so xen timestamps work early as well now.
> 

Oops, yes, my mistake. I will test the patchset with Thomas's kvm patch
for you.

Thanks,
	dou

> Thank you,
> Pavel
> 
> 
> 
