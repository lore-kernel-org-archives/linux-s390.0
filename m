From: "Reshetova, Elena" <elena.reshetova@intel.com>
Subject: RE: [PATCH 3/4] sparc: convert mdesc_handle.refcnt from atomic_t to
 refcount_t
Date: Mon, 3 Apr 2017 07:28:01 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612B41C86E2F@IRSMSX102.ger.corp.intel.com>
References: <1487588781-15123-1-git-send-email-elena.reshetova@intel.com>
        <1487588781-15123-4-git-send-email-elena.reshetova@intel.com>
 <20170220.095658.2221033513472748245.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170220.095658.2221033513472748245.davem@davemloft.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "Luck, Tony" <tony.luck@intel.com>, "hpa@zytor.com" <hpa@zytor.com>, "ishkamiel@gmail.com" <ishkamiel@gmail.com>, "keescook@chromium.org" <keescook@chromium.org>, "dwindsor@gmail.com" <dwindsor@gmail.com>
List-ID: <linux-s390.vger.kernel.org>


> From: Elena Reshetova <elena.reshetova@intel.com>
> Date: Mon, 20 Feb 2017 13:06:20 +0200
>=20
> > refcount_t type and corresponding API should be
> > used instead of atomic_t when the variable is used as
> > a reference counter. This allows to avoid accidental
> > refcounter overflows that might lead to use-after-free
> > situations.
> >
> > Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> > Signed-off-by: Hans Liljestrand <ishkamiel@gmail.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: David Windsor <dwindsor@gmail.com>
>=20
> Acked-by: David S. Miller <davem@davemloft.net>

Hi David,=20

Would you be able to propagate this patch further or should I send it (with=
 your acked-by) once more to specific list/maintainer for the inclusion?

Best Regards,
Elena
