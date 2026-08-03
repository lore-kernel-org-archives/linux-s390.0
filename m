Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436984302E6;
	Mon,  3 Aug 2026 18:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781677; cv=none; b=mJWa84TjMK7bVIc9iDKMRlzg/wQ2OHjEQ/a6c8LLujFNpNdDEx0GWWCo/gJLfhsw4ztG9LeeIgdB2Qd3wxJtBQ9usQA84mIxu8rM97sAnjrz6a95WHxkhY8AWDNEN1DkOyYfkLQMH11Y/FR3BvO8oja+lfD6meKIQeFjFpTf9g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781677; c=relaxed/simple;
	bh=+b5Zt8N5u8ceyNy6jaE+YMFKjylcF0QwxRF/OlBnuUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qnnXB298SUBfcx8jsphMlIAgK4xYIQ28z5IHGGBnsNl+oLaJvILZLLHjvVFnMWNOOBf3H2aHRyrwrCRzglHW5D7J9PWfEGxZsy/f6F31VvsM+YFosYAKuwxS2hdkth5nDo5qfxZFrtWEHgr6GEfcIHnFIb4l+0HsRap6xVixy74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=De3NQcPn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="De3NQcPn"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673HHhuH2663605;
	Mon, 3 Aug 2026 18:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=ksTD/8MPxOmUQsy0DsNgAfCZs/Kp
	RMuPv1ceYts0d9I=; b=De3NQcPneRc9iW+cOwYDV5C/4cD5JuIUbwSDX1K9f0Ev
	4Z2+ZxNOGgYZvm0/+Fj/R3MdfQp6XwXI+EJS934SpCcYPeWtSyhuBiaU7zdSjWTY
	W/WSpzCqTg8gqjF05SjsQOPwcBUR+jYyrI28P28exTO0P3xBg0czjU+/+jTXRrXm
	T4xr1ZYVxgq33H1d9hKwii3EsYYMc0cOtfHYSuM939EGakVRFn5KwxdQmFhHSLWa
	kSdkSjmtg4yKZ7+iAmrinyAW+ANIz7E0EQXRcgVeHKcOCFZrm/T2dPamyF08tlsd
	IYoGnugavzWdYlnvgp0y6I/tt+fcARyXJXCtMI/auA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3t9fj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 18:27:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673IQIqE010885;
	Mon, 3 Aug 2026 18:27:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg6fj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 18:27:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673IRbrm36045278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 18:27:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AB0D20043;
	Mon,  3 Aug 2026 18:27:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E602C20040;
	Mon,  3 Aug 2026 18:27:36 +0000 (GMT)
Received: from t83lp71.lnxne.boe (unknown [9.87.84.240])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 18:27:36 +0000 (GMT)
From: Nagamani PV <nagamani@linux.ibm.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org, wintera@linux.ibm.com, aswin@linux.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net-next] s390/ctcm: Convert fsm.h to proper kernel-doc format
Date: Mon,  3 Aug 2026 20:27:36 +0200
Message-ID: <20260803182736.2356374-1-nagamani@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a70dd9e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=peGaGOMV5x4x2WVhuBYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 2kIjeWB9rM7a6XsXVu0s7tZNY1zFpGcP
X-Proofpoint-GUID: N1XjypU_FnJVtQxQF0ZRckX8UQ6PTFYl
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE2MiBTYWx0ZWRfXy5x0iOXowigc
 /krwsDq6eFty9J9wU5HKXP3U5Jwssx6zVOZ2g5NQQvPCYdQkKX3RC9OXzExLkYM8GU2351V07j7
 gIjgXgk1kyB6v3L3I36S5gXL+JE5w6Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE2MiBTYWx0ZWRfXzbwzjl7Imv6O
 ljJx0dKKD68iUAG1JMr2OOLZ4o2747jP/nyYv/MAtZoiES5jPy97iQtmvySRbQjp8X5eQnHEYej
 qWgLeFQyiBFFWVXga2Tfs3e8LpdyCZXDq//Mwwb5KdLQRzb/M+xLXjyqh75hDOFEoP6YVz4F2rs
 f0LUwCFylnIYwR2Jq+6jjk/WOmZjiW4/BmeGc6FysKz/0Ky/X/tKVZYH+Cq9577f1QaB+pyXpB1
 wT1iro0mhnh6ke7yssVjDPMMD37vAXeEIDGIzEt9x4OvwATq9Tsup2tHyn5K79BZy/3VHHbomRk
 nZSDcNwICRDXkhd1tHTNHl6payLQWhxmMRrfO7RlCOsPIs4DxUj70YBzy9PalEBS3Fhi9wZZR12
 XC8g3KN/cJTpitplh/Fb2HnonRyIF5w+CXglNn1njqGcbMHdjLZBoiO7TQ3XRyxiFevLG/oFH8q
 8ECZyd4ad1HfxyEKcTg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_04,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030162

drivers/s390/net/fsm.h contains comments starting with '/**'
that don't follow kernel-doc syntax, triggering warnings when
running:

  scripts/kernel-doc -none -Wall drivers/s390/net/fsm*

Example warning:
Warning: drivers/s390/net/fsm.h:14 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
 * Define this to get debugging messages.

Convert function declarations to proper kernel-doc format per
Documentation/doc-guide/kernel-doc.rst. Change debug macros and
internal structure comments from '/**' to '/*' since they are
not part of the public API. Also add missing parameter name in
fsm_settimer() declaration to match the implementation. Remove
redundant extern keywords from all function declarations.

No functional change.

Reviewed-by: Aswin Karuvally <aswin@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Nagamani PV <nagamani@linux.ibm.com>

---
 drivers/s390/net/fsm.h | 152 +++++++++++++++++++++--------------------
 1 file changed, 78 insertions(+), 74 deletions(-)

diff --git a/drivers/s390/net/fsm.h b/drivers/s390/net/fsm.h
index 16dc071a2973..6a0b47ca87f0 100644
--- a/drivers/s390/net/fsm.h
+++ b/drivers/s390/net/fsm.h
@@ -11,18 +11,18 @@
 #include <linux/string.h>
 #include <linux/atomic.h>
 
-/**
+/*
  * Define this to get debugging messages.
  */
 #define FSM_DEBUG         0
 
-/**
+/*
  * Define this to get debugging massages for
  * timer handling.
  */
 #define FSM_TIMER_DEBUG   0
 
-/**
+/*
  * Define these to record a history of
  * Events/Statechanges and print it if a
  * action_function is not found.
@@ -32,12 +32,12 @@
 
 struct fsm_instance_t;
 
-/**
+/*
  * Definition of an action function, called by a FSM
  */
 typedef void (*fsm_function_t)(struct fsm_instance_t *, int, void *);
 
-/**
+/*
  * Internal jump table for a FSM
  */
 typedef struct {
@@ -49,7 +49,7 @@ typedef struct {
 } fsm;
 
 #if FSM_DEBUG_HISTORY
-/**
+/*
  * Element of State/Event history used for debugging.
  */
 typedef struct {
@@ -58,7 +58,7 @@ typedef struct {
 } fsm_history;
 #endif
 
-/**
+/*
  * Representation of a FSM
  */
 typedef struct fsm_instance_t {
@@ -75,7 +75,7 @@ typedef struct fsm_instance_t {
 #endif
 } fsm_instance;
 
-/**
+/*
  * Description of a state-event combination
  */
 typedef struct {
@@ -84,7 +84,7 @@ typedef struct {
 	fsm_function_t function;
 } fsm_node;
 
-/**
+/*
  * Description of a FSM Timer.
  */
 typedef struct {
@@ -95,50 +95,52 @@ typedef struct {
 } fsm_timer;
 
 /**
- * Creates an FSM
+ * init_fsm - Creates a finite state machine
+ * @name: Name of this instance for logging purposes
+ * @state_names: Array of names for all states for logging purposes
+ * @event_names: Array of names for all events for logging purposes
+ * @nr_states: Number of states for this instance
+ * @nr_events: Number of events for this instance
+ * @tmpl: Pointer to fsm_node array describing this FSM
+ * @tmpl_len: Number of entries in the tmpl array
+ * @order: GFP flags for memory allocation (e.g. GFP_KERNEL)
  *
- * @param name        Name of this instance for logging purposes.
- * @param state_names An array of names for all states for logging purposes.
- * @param event_names An array of names for all events for logging purposes.
- * @param nr_states   Number of states for this instance.
- * @param nr_events   Number of events for this instance.
- * @param tmpl        An array of fsm_nodes, describing this FSM.
- * @param tmpl_len    Length of the describing array.
- * @param order       Parameter for allocation of the FSM data structs.
+ * Allocates and initializes a finite state machine instance with the
+ * specified states, events, and transition table.
+ *
+ * Return: Pointer to initialized FSM instance, or NULL on failure
  */
-extern fsm_instance *
-init_fsm(char *name, const char **state_names,
-	 const char **event_names,
-	 int nr_states, int nr_events, const fsm_node *tmpl,
-	 int tmpl_len, gfp_t order);
+fsm_instance *init_fsm(char *name, const char **state_names,
+		       const char **event_names, int nr_states,
+		       int nr_events, const fsm_node *tmpl,
+		       int tmpl_len, gfp_t order);
 
 /**
- * Releases an FSM
+ * kfree_fsm - Releases a finite state machine
+ * @fi: Pointer to FSM instance, previously created with init_fsm()
  *
- * @param fi Pointer to an FSM, previously created with init_fsm.
+ * Frees all memory associated with the FSM instance.
  */
-extern void kfree_fsm(fsm_instance *fi);
+void kfree_fsm(fsm_instance *fi);
 
 #if FSM_DEBUG_HISTORY
-extern void
-fsm_print_history(fsm_instance *fi);
+void fsm_print_history(fsm_instance *fi);
 
-extern void
-fsm_record_history(fsm_instance *fi, int state, int event);
+void fsm_record_history(fsm_instance *fi, int state, int event);
 #endif
 
 /**
- * Emits an event to a FSM.
- * If an action function is defined for the current state/event combination,
- * this function is called.
+ * fsm_event - Emits an event to a finite state machine
+ * @fi: Pointer to FSM which should receive the event
+ * @event: The event to be delivered
+ * @arg: Generic argument, passed to the action function
  *
- * @param fi    Pointer to FSM which should receive the event.
- * @param event The event do be delivered.
- * @param arg   A generic argument, handed to the action function.
+ * If an action function is defined for the current state/event
+ * combination, that function is called with the provided arguments.
  *
- * @return      0  on success,
- *              1  if current state or event is out of range
- *              !0 if state and event in range, but no action defined.
+ * Return:
+ * * 0 - Success, action function was called
+ * * 1 - State/event out of range, or no action function defined
  */
 static inline int
 fsm_event(fsm_instance *fi, int event, void *arg)
@@ -182,11 +184,12 @@ fsm_event(fsm_instance *fi, int event, void *arg)
 }
 
 /**
- * Modifies the state of an FSM.
- * This does <em>not</em> trigger an event or calls an action function.
+ * fsm_newstate - Modifies the state of a finite state machine
+ * @fi: Pointer to FSM
+ * @newstate: The new state for this FSM
  *
- * @param fi    Pointer to FSM
- * @param state The new state for this FSM.
+ * This does not trigger an event or call an action function.
+ * Wakes up any processes waiting on the FSM's wait queue.
  */
 static inline void
 fsm_newstate(fsm_instance *fi, int newstate)
@@ -203,11 +206,10 @@ fsm_newstate(fsm_instance *fi, int newstate)
 }
 
 /**
- * Retrieves the state of an FSM
- *
- * @param fi Pointer to FSM
+ * fsm_getstate - Retrieves the current state of a finite state machine
+ * @fi: Pointer to FSM
  *
- * @return The current state of the FSM.
+ * Return: Current state number
  */
 static inline int
 fsm_getstate(fsm_instance *fi)
@@ -216,51 +218,53 @@ fsm_getstate(fsm_instance *fi)
 }
 
 /**
- * Retrieves the name of the state of an FSM
- *
- * @param fi Pointer to FSM
+ * fsm_getstate_str - Retrieves the name of the current FSM state
+ * @fi: Pointer to FSM
  *
- * @return The current state of the FSM in a human readable form.
+ * Return: State name string, or "Invalid" if state is out of range
  */
-extern const char *fsm_getstate_str(fsm_instance *fi);
+const char *fsm_getstate_str(fsm_instance *fi);
 
 /**
- * Initializes a timer for an FSM.
- * This prepares an fsm_timer for usage with fsm_addtimer.
+ * fsm_settimer - Initializes a timer for a finite state machine
+ * @fi: Pointer to FSM
+ * @this: The timer to be initialized
  *
- * @param fi    Pointer to FSM
- * @param timer The timer to be initialized.
+ * Prepares an fsm_timer for usage with fsm_addtimer().
  */
-extern void fsm_settimer(fsm_instance *fi, fsm_timer *);
+void fsm_settimer(fsm_instance *fi, fsm_timer *this);
 
 /**
- * Clears a pending timer of an FSM instance.
+ * fsm_deltimer - Clears a pending timer of an FSM instance
+ * @timer: The timer to clear
  *
- * @param timer The timer to clear.
+ * Stops and removes the timer. Safe to call on an inactive timer.
  */
-extern void fsm_deltimer(fsm_timer *timer);
+void fsm_deltimer(fsm_timer *timer);
 
 /**
- * Adds and starts a timer to an FSM instance.
+ * fsm_addtimer - Adds and starts a timer for an FSM instance
+ * @timer: The timer to be added (timer->fi must point to the FSM instance)
+ * @millisec: Duration in milliseconds after which the timer expires
+ * @event: Event to trigger when timer expires
+ * @arg: Generic argument provided to the event handler
  *
- * @param timer    The timer to be added. The field fi of that timer
- *                 must have been set to point to the instance.
- * @param millisec Duration, after which the timer should expire.
- * @param event    Event, to trigger if timer expires.
- * @param arg      Generic argument, provided to expiry function.
+ * Starts a timer that will trigger the specified event after the given
+ * duration. The timer must have been initialized with fsm_settimer().
  *
- * @return         0 on success, -1 if timer is already active.
+ * Return: Always returns 0
  */
-extern int fsm_addtimer(fsm_timer *timer, int millisec, int event, void *arg);
+int fsm_addtimer(fsm_timer *timer, int millisec, int event, void *arg);
 
 /**
- * Modifies a timer of an FSM.
+ * fsm_modtimer - Modifies a timer of a finite state machine
+ * @timer: The timer to modify
+ * @millisec: New duration in milliseconds after which the timer expires
+ * @event: Event to trigger when timer expires
+ * @arg: Generic argument provided to the event handler
  *
- * @param timer    The timer to modify.
- * @param millisec Duration, after which the timer should expire.
- * @param event    Event, to trigger if timer expires.
- * @param arg      Generic argument, provided to expiry function.
+ * Stops the existing timer and restarts it with new parameters.
  */
-extern void fsm_modtimer(fsm_timer *timer, int millisec, int event, void *arg);
+void fsm_modtimer(fsm_timer *timer, int millisec, int event, void *arg);
 
 #endif /* _FSM_H_ */
-- 
2.53.0

