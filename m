Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
References: <20180712000419.5165-1-pasha.tatashin@oracle.com>
 <20180712000419.5165-14-pasha.tatashin@oracle.com> <928b8490-89d2-46a3-8596-16751bcd12db@cn.fujitsu.com>
 <CAGM2reb-MwiT8qoiSkXCjAAM46JOYL9BP+U3q7PMTcxp9EiK7w@mail.gmail.com>
 <01812492-b88b-4436-570b-ef776eaafc6a@cn.fujitsu.com> <CAGM2reaU1GouLvUfW_dbs7gFiYCMX=X+Vag2RnuofmmgS4_TdA@mail.gmail.com>
 <4f6b295d-c88b-2204-0557-ae85ed443a31@cn.fujitsu.com>
In-Reply-To: <4f6b295d-c88b-2204-0557-ae85ed443a31@cn.fujitsu.com>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 17 Jul 2018 10:36:27 -0400
Message-ID: <CAGM2reZJHRXuWNaLpJRtkbx0V4FJD78dvCNAsMg8X4cF2qeQuw@mail.gmail.com>
Subject: Re: [PATCH v13 13/18] x86/tsc: calibrate tsc only once
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: douly.fnst@cn.fujitsu.com
Cc: Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, schwidefsky@de.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com
List-ID: <linux-s390.vger.kernel.org>

>
> Oops, yes, my mistake. I will test the patchset with Thomas's kvm patch
> for you.

Thank you Dou. Please wait for updated series before you test it. I
will include patches from Thomas in the updated series.

Thank you,
Pavel
